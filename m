Return-Path: <cyrus@holtmann.org>
Message-ID: <50C3F088.2090203@globaledgesoft.com>
Date: Sun, 09 Dec 2012 07:29:36 +0530
From: Ajay <ajay.kv@globaledgesoft.com>
MIME-Version: 1.0
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: BLE issue: Start_LE_Encryption fails
References: <508D6672.8000009@globaledgesoft.com> <CAJdJm_MXB71MTcbrViLh486RtpWpx+a7SDvUPdSj2VdOa1fWvw@mail.gmail.com> <CAJdJm_NHaBzobi=k3cMaM-J_3d6R7FCEvfrSJWbkiKxKpjKHWA@mail.gmail.com> <508DCE10.40801@globaledgesoft.com> <CAJdJm_P=USyDO5op7_7ynOT8Qe7dOifyN=notezK1HGCxOe8bA@mail.gmail.com> <508DDCE7.6030708@globaledgesoft.com> <CAJdJm_PLSAZBc+ef_YXsmQ+VE5aW3aD_CPs3x2Y7gY+8zY19Bw@mail.gmail.com> <50BE45BB.409@globaledgesoft.com> <CAJdJm_Miiidw08Tk2-6mtoDFQ0uhyez=H+NKRK-2UYjyTQ9d1A@mail.gmail.com>
In-Reply-To: <CAJdJm_Miiidw08Tk2-6mtoDFQ0uhyez=H+NKRK-2UYjyTQ9d1A@mail.gmail.com>
Content-Type: multipart/mixed;
 boundary="------------030508000302040108090402"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is a multi-part message in MIME format.
--------------030508000302040108090402
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On Thursday 06 December 2012 04:20 PM, Anderson Lizardo wrote:
> Hi Ajay,
>
> On Tue, Dec 4, 2012 at 2:49 PM, Ajay <ajay.kv@globaledgesoft.com> wrote:
>> SLAVE side
>>
>> root@test:/home#  hcitool -i hci0 cmd 0x08 0x0008 03 02 01 06 \
>>
>>                          $(perl -e 'print "00 " x 28')
>> root@test:/home# hciconfig hci0  leadv
>>
>>
>> Hcidump shows ..
>>
>> < HCI Command: LE Set Advertising Data (0x08|0x0008) plen 32
>>> HCI Event: Command Complete (0x0e) plen 4
>>      LE Set Advertising Data (0x08|0x0008) ncmd 1
>>      status 0x00
>> < HCI Command: LE Set Advertise Enable (0x08|0x000a) plen 1
>>> HCI Event: Command Complete (0x0e) plen 4
>>      LE Set Advertise Enable (0x08|0x000a) ncmd 1
>>      status 0x00
>>
>>> HCI Event: LE Meta Event (0x3e) plen 19
>>      LE Connection Complete
>>        status 0x00 handle 64, role slave
>>        bdaddr 00:02:72:D6:AB:AD (Public)
>>> ACL data: handle 64 flags 0x02 dlen 11
>>      ATT: Read By Group req (0x10)
>>        start 0x0001, end 0xffff
>>        type-uuid 0x2800
>
> Your slave device is not answering to the Read By Group request,
> therefore the master side is disconnecting due to timeout.
>
> I suggest you first try using gatttool on the master side to connect
> to the slave, and run "primary" to see if it is processing GATT
> requests.
>
> The bluez log from the slave side should help (I assume you are
> running BlueZ on the slave side).
>
> Regards,
>


Hi,
     I tried  "gatttool  -i hci0 -b <remote bdaddr> --primary " on 
master side  ,which creates   LE link and very next moment disconnects . 
How can i change the security level  of the link to medium?. still 
struggling to pair the device  (atleast "smp just works") ) . Is my 
kernel supportive (3.2.5)

	  few lines of code from the kernel (/net/bluetooth/smp.c)
	

int smp_conn_security(struct l2cap_conn *conn, __u8 sec_level)
{
         struct hci_conn *hcon = conn->hcon;
         struct smp_chan *smp = conn->smp_chan;

         BT_DBG("conn %p hcon %p level 0x%2.2x", conn, hcon, sec_level);

         if (!lmp_host_le_capable(hcon->hdev))
                 return 1;

         if (sec_level == BT_SECURITY_LOW)
                 return 1;

         if (hcon->sec_level >= sec_level)
                 return 1;

         if (hcon->link_mode & HCI_LM_MASTER)
                 if (smp_ltk_encrypt(conn))
                         goto done;

         if (test_and_set_bit(HCI_CONN_LE_SMP_PEND, &hcon->pend))
                 return 0;

         smp = smp_chan_create(conn);

         if (hcon->link_mode & HCI_LM_MASTER) {
                 struct smp_cmd_pairing cp;

                 build_pairing_cmd(conn, &cp, NULL, SMP_AUTH_NONE);
                 smp->preq[0] = SMP_CMD_PAIRING_REQ;
                 memcpy(&smp->preq[1], &cp, sizeof(cp));

                 smp_send_cmd(conn, SMP_CMD_PAIRING_REQ, sizeof(cp), &cp);


	Every time on LE create connection  process 	i	,smp_conn_security() 
getting called from hci layer .
   But  if(host_le_capable(hcon->hdev))
                 return 1;
condition returns without even checking the security level . so kindly 
show me the right way..	

   	

-- 
Thanks & Regards

  AJAY KV
  GlobalEdge software Ltd
  8892753703

--------------030508000302040108090402
Content-Type: text/x-vcard; charset=utf-8;
 name="ajay_kv.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="ajay_kv.vcf"

begin:vcard
fn:AJAY KV
n:;AJAY
tel;cell:8892753703
version:2.1
end:vcard


--------------030508000302040108090402--
