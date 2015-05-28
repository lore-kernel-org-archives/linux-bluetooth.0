Return-Path: <cyrus@holtmann.org>
From: Ankur Patel <ankur@embertec.com>
To: Szymon Janc <szymon.janc@tieto.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Thu, 28 May 2015 18:07:48 +0930
Subject: RE: Issue: Sending ATT Signed Write Command via btgatt-client
Message-ID: <BD5E516FF3711A41B93DC005170007BB010E5DB57E91@EMBSVR01.ember.local>
References: <BD5E516FF3711A41B93DC005170007BB010E5DB57E78@EMBSVR01.ember.local>
 <1831684.talzOfVBnx@leonov>
In-Reply-To: <1831684.talzOfVBnx@leonov>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

> Hi Ankur,
> 
> On Thursday 28 of May 2015 16:47:09 Ankur Patel wrote:
> > Hello Folks,
> >
> > I would like to Send Signed Write command to modify a characteristic
> > on the Host. It failed into the Error: Failed to initiate write
> > without response procedure
> >
> > Information on Controller (May be helpful):
> > root@imx28evk:~# cat /proc/crypto
> > name         : ecb(aes)
> > driver       : ecb-aes-dcp
> > module       : kernel
> > priority     : 400
> > refcnt       : 1
> > selftest     : passed
> > type         : ablkcipher
> > async        : yes
> > blocksize    : 16
> > min keysize  : 16
> > max keysize  : 32
> > ivsize       : 0
> > geniv        : <default>
> >
> > root@imx28evk:~# btmgmt info
> > Index list with 1 item
> > hci0:   Primary controller
> >         addr 1C:BA:8C:86:81:21 version 6 manufacturer 13 class 0x000000
> >         supported settings: powered connectable fast-connectable
> > discoverable bondable link-security ssp br/edr hs le advertising
> > debug-keys privacy current settings: powered connectable discoverable
> > bondable link-security br/edr le advertising name testbt
> >         short name
> >
> >
> > root@imx28evk:~/tools# btgatt-client -d 00:1B:DC:07:2E:85 Connecting
> > to device... Done Service Added - UUID:
> > 00001800-0000-1000-8000-00805f9b34fb start: 0x0001
> > end: 0x000d Service Added - UUID: 00001801-0000-1000-8000-00805f9b34fb
> > start: 0x0014 end: 0x0016 [GATT client]# GATT discovery procedures
> > complete [GATT client]# ...
> > [GATT client]# set-sign-key -c efcdab8967452301efcdab8967452301 [GATT
> > client]# write-value -s -w 0xd 01 Failed to initiate write without
> > response procedure
> >
> > I tried to trace the error as:
> > bt_gatt_client_write_without_response(..) -> bt_att_send(..) ->
> > create_att_send_op(..) -> encode_pdu(..) -> bt_crypto_sign_att(..) ->
> > As
> > att->crypto is NULL it returns false.
> >
> > I tried to check the reason for att->crypto to be NULL. Found that
> > while initialization of the btgatt-client, under bt_crypto_new() ->
> > crypto->ecb_aes = ecb_aes_setup();. It fails under ecb_aes_setup
> function.
> > From the output of /proc/crypto, the kernel has the support. I am
> > wondering how to enable the crypto?
> 
> Most likely following options are missing in your kernel configuration:
> CONFIG_CRYPTO_CMAC
> CONFIG_CRYPTO_USER_API
> CONFIG_CRYPTO_USER_API_HASH
> CONFIG_CRYPTO_USER_API_SKCIPHER
> 
It Worked!!. Thank you Szymon for quick response.

Now I am able to send the Signed Write Command but without Authentication Signature. If I understood it correctly, 
1) Set the Signature using  [GATT client]# set-sign-key -c efcdab8967452301efcdab8967452301
2) Execute command: write-value -s -w 0xd 01  to send write command.

 I couldn't able to see the signature on the Sniffer. 
In addition on the Controller I see below output of root@imx28evk:~#Btmon:

< ACL Data TX: Handle 1025 flags 0x00 dlen 20                                                                                                                                                                                                      [hci0] 2394.331806
      ATT: Signed Write Command (0xd2) len 15
        0d 00 01 03 00 00 00 47 8a ec df 50 fc a5 ba     .......G...P... 
> HCI Event: Number of Completed Packets (0x13) plen 5                                                                                                                                                                                             [hci0] 2394.462600
        Num handles: 1
        Handle: 1025
        Count: 1

Regards,
Ankur
> --
> BR
> Szymon Janc
