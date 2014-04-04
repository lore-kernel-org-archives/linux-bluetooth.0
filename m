Return-Path: <cyrus@holtmann.org>
Message-ID: <533ED37D.4050906@rwth-aachen.de>
Date: Fri, 4 Apr 2014 17:45:01 +0200
From: =?ISO-8859-1?Q?Jan_R=FCth?= <jan.rueth@rwth-aachen.de>
MIME-Version: 1.0
To: <linux-bluetooth@vger.kernel.org>
Subject: Need help on slave connection update request
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I'm looking for a possibility to send a connection update request from
the slave device.

I saw the old thread in the mailing list archive about it:
http://article.gmane.org/gmane.linux.bluez.kernel/44065

I need to do the same as the author did, however I found that the
methods never made it into the source here.

So I tried to recreate what the author described.

This is what I got:

#define L2CAP_CID_ATT           0x0004
#define L2CAP_CID_LE_SIGNALING  0x0005

#define L2CAP_CONN_PARAM_UPDATE_REQ 0x12

typedef struct {
    uint16_t acl_length; //1+1+2+8 = 12
    uint16_t channel_id;
    uint8_t code; // 0x12
    uint8_t identifier;
    uint16_t sig_length; // 2+2+2+2 = 8
    uint16_t min_interval;
    uint16_t max_interval;
    uint16_t slave_latency;
    uint16_t timeout_multiplier;
} __attribute__((__packed__)) le_signaling_packet_conn_update_req;


int le_send_acl(int dd, uint16_t handle, uint8_t dlen, void *data)
{
    uint8_t type = HCI_ACLDATA_PKT;
    hci_acl_hdr ha;
    uint16_t flags = acl_flags(btohs(handle));
    ha.handle = htobs(acl_handle_pack(handle, flags));
    ha.dlen = dlen;
   
    static uint8_t buf[4096];
    buf[0] = type;
    memcpy(buf + 1, &ha, HCI_ACL_HDR_SIZE);
    memcpy(buf + 1 + HCI_ACL_HDR_SIZE, data, dlen);
   
    while (write(dd, buf, dlen + 1 + HCI_ACL_HDR_SIZE) < 0) {
        if (errno == EAGAIN || errno == EINTR) {
            printf("Latency: error\n");
            continue;
        }
        printf("Latency: write failed\n");
        return -1;
    }
    printf("Latency: written\n");
    return 0;
}

void le_slave_conn_update(int dd, uint16_t handle, uint16_t min,
uint16_t max,
                          uint16_t latency, uint16_t to_multiplier)
{
    le_signaling_packet_conn_update_req sig;
    memset(&sig, 0, sizeof(sig));
    //fill acl header
    sig.acl_length = htobs(12);
    sig.channel_id = htobs(L2CAP_CID_LE_SIGNALING);
   
    // fill header
    sig.code = L2CAP_CONN_PARAM_UPDATE_REQ;
    sig.identifier = (uint8_t)rand();
    sig.sig_length = htobs(8);
   
    // fill payload
    sig.min_interval = htobs(min);
    sig.max_interval = htobs(max);
    sig.slave_latency = htobs(latency);
    sig.timeout_multiplier = htobs(to_multiplier);
   
   
    le_send_acl(dd, handle, sizeof(sig), &sig);
   
}


In the rest of my program I create a L2CAP server (using parameters I
obtained after a call to hci_open_dev) socket (which I bind on cid=
L2CAP_CID_ATT (=0x0004) ) and I'm able to accept connections and
exchange data with a connected master.

Now when I issue the "le_slave_conn_update" on the socket I obtained
from hci_open_dev together with the hciHandle I obtained from a call to
getsockopt(.., SOL_L2CAP, L2CAP_CONNINFO, ..) after a successful accept.
The master accepts my parameters (I see L2CAP_CONN_PARAM_UPDATE_RES
using btmon) and the correct LE Meta events are issued as well, however
now I cannot exchange data on the socket anymore. Do I need to do
anything else?

Please note that I use bluez 4.99 and a 3.10 kernel, I'm not sure if
this is already the problem.

I would be happy if you guys could help me out.

Thanks you!
 Jan

