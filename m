Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1434021563-5761-1-git-send-email-bharat.panda@samsung.com>
References: <1434021563-5761-1-git-send-email-bharat.panda@samsung.com>
Date: Fri, 12 Jun 2015 13:46:23 +0300
Message-ID: <CABBYNZKC2Dmm0stPTMTFw_a8s7egcfj0Cq9HKjz4rCNhQVNebw@mail.gmail.com>
Subject: Re: [PATCH ] tools/l2test: Add support for l2cap config request
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Bharat Panda <bharat.panda@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	cpgs@samsung.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bharat,

On Thu, Jun 11, 2015 at 2:19 PM, Bharat Panda <bharat.panda@samsung.com> wrote:
> This allows to send l2cap configuration request by providing
> '-o' option to l2test along with '-f' option to add destination CID.
>
> e.g.,
>
> l2test command format:
> l2test -o -X <mode> -f <destination CID> -P <psm> <bd_addr>

But the kernel should handle this for us, why do you need to do it manually?

> ---
>  lib/l2cap.h    |  10 ++++
>  tools/l2test.c | 162 +++++++++++++++++++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 167 insertions(+), 5 deletions(-)
>
> diff --git a/lib/l2cap.h b/lib/l2cap.h
> index 5ce94c4..85f3c80 100644
> --- a/lib/l2cap.h
> +++ b/lib/l2cap.h
> @@ -235,6 +235,16 @@ typedef struct {
>  #define L2CAP_IR_NOTSUPP       0x0001
>
>  typedef struct {
> +    uint8_t    mode;
> +    uint8_t    txwin_size;
> +    uint8_t    max_transmit;
> +    uint16_t   retrans_timeout;
> +    uint16_t   monitor_timeout;
> +    uint16_t   max_pdu_size;
> +} __attribute__ ((packed)) l2cap_conf_rfc ;
> +#define L2CAP_CONF_RFC_SIZE 9
> +
> +typedef struct {
>         uint16_t        psm;
>         uint16_t        scid;
>         uint8_t         id;
> diff --git a/tools/l2test.c b/tools/l2test.c
> index abe09c1..59500fb 100644
> --- a/tools/l2test.c
> +++ b/tools/l2test.c
> @@ -69,9 +69,13 @@ enum {
>         LSENDRECV,
>         CSENDRECV,
>         INFOREQ,
> +       CONFIGREQ,
>         PAIRING,
>  };
>
> +#define L2CAP_DEFAULT_RETRANS_TO       2000    /* 2 seconds */
> +#define L2CAP_DEFAULT_MONITOR_TO       12000   /* 12 seconds */
> +
>  static unsigned char *buf;
>
>  /* Default mtu */
> @@ -91,10 +95,11 @@ static int max_transmit = 3;
>  static long data_size = -1;
>  static long buffer_size = 2048;
>
> -/* Default addr and psm and cid */
> +/* Default addr, psm, cid and dcid */
>  static bdaddr_t bdaddr;
>  static unsigned short psm = 0;
>  static unsigned short cid = 0;
> +static uint16_t dcid = 0;
>
>  /* Default number of frames to send (-1 = infinite) */
>  static int num_frames = -1;
> @@ -1245,6 +1250,138 @@ failed:
>         close(sk);
>  }
>
> +static void l2cap_add_conf_opt(void **ptr, uint8_t type,
> +                                       uint8_t len, unsigned long val)
> +{
> +       l2cap_conf_opt *opt = *ptr;
> +
> +       printf("type 0x%2.2x len %u val 0x%lx \n", type, len, val);
> +
> +       opt->type = htobs(type);
> +       opt->len  = htobs(len);
> +
> +       switch (opt->len) {
> +       case 1:
> +               *((uint8_t *) opt->val) = val;
> +               break;
> +       case 2:
> +               bt_put_le16(val, opt->val);
> +               break;
> +       case 4:
> +               bt_put_le32(val, opt->val);
> +               break;
> +       default:
> +               memcpy(opt->val, (void *) val, len);
> +               break;
> +       }
> +
> +       *ptr += L2CAP_CONF_OPT_SIZE + len;
> +}
> +
> +static int l2cap_build_conf_req(void *data)
> +{
> +       l2cap_conf_req *req = data;
> +       l2cap_conf_rfc rfc;
> +       void *ptr = req->data;
> +
> +       req->dcid = htobs(dcid);
> +       req->flags = htobs(0x0000);
> +
> +       switch (rfcmode) {
> +       case L2CAP_MODE_BASIC:
> +               rfc.mode                = htobs(L2CAP_MODE_BASIC);
> +               rfc.txwin_size          = htobs(0);
> +               rfc.max_transmit        = htobs(0);
> +               rfc.retrans_timeout = htobs(0);
> +               rfc.monitor_timeout = htobs(0);
> +               rfc.max_pdu_size        = htobs(0);
> +
> +               l2cap_add_conf_opt(&ptr, L2CAP_CONF_RFC, sizeof(rfc),
> +                                                       (unsigned long) &rfc);
> +
> +               break;
> +
> +       case L2CAP_MODE_ERTM:
> +               rfc.mode                = htobs(L2CAP_MODE_ERTM);
> +               rfc.txwin_size          = htobs(txwin_size);
> +               rfc.max_transmit        = htobs(max_transmit);
> +               rfc.retrans_timeout     = htobs(L2CAP_DEFAULT_RETRANS_TO);
> +               rfc.monitor_timeout     = htobs(L2CAP_DEFAULT_MONITOR_TO);
> +               rfc.max_pdu_size        = htobs(imtu);
> +
> +               l2cap_add_conf_opt(&ptr, L2CAP_CONF_RFC, sizeof(rfc),
> +                                                       (unsigned long) &rfc);
> +               break;
> +
> +       case L2CAP_MODE_STREAMING:
> +               rfc.mode                = htobs(L2CAP_MODE_STREAMING);
> +               rfc.txwin_size          = htobs(txwin_size);
> +               rfc.max_transmit        = htobs(max_transmit);
> +               rfc.retrans_timeout = htobs(L2CAP_DEFAULT_RETRANS_TO);
> +               rfc.monitor_timeout = htobs(L2CAP_DEFAULT_MONITOR_TO);
> +               rfc.max_pdu_size        = htobs(imtu);
> +
> +               l2cap_add_conf_opt(&ptr, L2CAP_CONF_RFC, sizeof(rfc),
> +                                                       (unsigned long) &rfc);
> +
> +               break;
> +       default:
> +               return L2CAP_CONF_REQ_SIZE;
> +       }
> +
> +       return (ptr - data);
> +}
> +
> +static void config_request(char *svr)
> +{
> +       unsigned char buf[48];
> +       l2cap_cmd_hdr *cmd = (l2cap_cmd_hdr *) buf;
> +       uint8_t *req_buf = (uint8_t *) (buf + L2CAP_CMD_HDR_SIZE);
> +       struct sockaddr_l2 addr;
> +       int sk;
> +       int data_len = 0;
> +
> +       sk = socket(PF_BLUETOOTH, SOCK_RAW, BTPROTO_L2CAP);
> +       if (sk < 0) {
> +               perror("Can't create socket");
> +               return;
> +       }
> +
> +       memset(&addr, 0, sizeof(addr));
> +       addr.l2_family = AF_BLUETOOTH;
> +       bacpy(&addr.l2_bdaddr, &bdaddr);
> +       addr.l2_bdaddr_type = bdaddr_type;
> +
> +       if (bind(sk, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
> +               perror("Can't bind socket");
> +               goto failed;
> +       }
> +
> +       memset(&addr, 0, sizeof(addr));
> +       addr.l2_family = AF_BLUETOOTH;
> +       str2ba(svr, &addr.l2_bdaddr);
> +       addr.l2_bdaddr_type = bdaddr_type;
> +
> +       if (connect(sk, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
> +               perror("Can't connect socket");
> +               goto failed;
> +       }
> +
> +       memset(buf, 0, sizeof(buf));
> +       cmd->code  = L2CAP_CONF_REQ;
> +       cmd->ident = 141;
> +       data_len = l2cap_build_conf_req(req_buf);
> +       cmd->len = htobs(data_len);
> +
> +       if (send(sk, buf, L2CAP_CMD_HDR_SIZE + data_len, 0) < 0) {
> +               perror("Can't send info request");
> +               goto failed;
> +       }
> +
> +failed:
> +       close(sk);
> +}
> +
>  static void do_pairing(char *svr)
>  {
>         struct sockaddr_l2 addr;
> @@ -1311,7 +1448,8 @@ static void usage(void)
>                 "\t-c connect, disconnect, connect, ...\n"
>                 "\t-m multiple connects\n"
>                 "\t-p trigger dedicated bonding\n"
> -               "\t-z information request\n");
> +               "\t-z information request\n"
> +               "\t-o configuration request\n");
>
>         printf("Options:\n"
>                 "\t[-b bytes] [-i device] [-P psm] [-J cid]\n"
> @@ -1340,7 +1478,7 @@ static void usage(void)
>                 "\t[-M] become master\n"
>                 "\t[-T] enable timestamps\n"
>                 "\t[-V type] address type (help for list, default = bredr)\n"
> -               "\t[-e seq] initial sequence value (default = 0)\n");
> +               "\t[-e DCID] Destination CID\n");
>  }
>
>  int main(int argc, char *argv[])
> @@ -1350,8 +1488,8 @@ int main(int argc, char *argv[])
>
>         bacpy(&bdaddr, BDADDR_ANY);
>
> -       while ((opt = getopt(argc, argv, "a:b:cde:g:i:mnpqrstuwxyz"
> -               "AB:C:D:EF:GH:I:J:K:L:MN:O:P:Q:RSTUV:W:X:Y:Z:")) != EOF) {
> +       while ((opt = getopt(argc, argv, "a:b:cde:g:i:mnopqrstuwxyz"
> +               "AB:C:D:EFf:GH:I:J:K:L:MN:O:P:Q:RSTUV:W:X:Y:Z:")) != EOF) {
>                 switch (opt) {
>                 case 'r':
>                         mode = RECV;
> @@ -1412,6 +1550,11 @@ int main(int argc, char *argv[])
>                         need_addr = 1;
>                         break;
>
> +               case 'o':
> +                       mode = CONFIGREQ;
> +                       need_addr = 1;
> +                       break;
> +
>                 case 'p':
>                         mode = PAIRING;
>                         need_addr = 1;
> @@ -1565,6 +1708,11 @@ int main(int argc, char *argv[])
>                         disc_delay = atoi(optarg) * 1000;
>                         break;
>
> +               case 'f':
> +                       dcid = strtoul(optarg, NULL, 16);
> +                       printf("dcid 0x%2x", dcid);
> +                       break;
> +
>                 default:
>                         usage();
>                         exit(1);
> @@ -1666,6 +1814,10 @@ int main(int argc, char *argv[])
>                         info_request(argv[optind]);
>                         exit(0);
>
> +               case CONFIGREQ:
> +                       config_request(argv[optind]);
> +                       exit(0);
> +
>                 case PAIRING:
>                         do_pairing(argv[optind]);
>                         exit(0);
> --
> 1.9.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz
