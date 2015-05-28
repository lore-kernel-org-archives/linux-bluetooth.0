Return-Path: <cyrus@holtmann.org>
From: Ankur Patel <ankur@embertec.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Thu, 28 May 2015 16:47:09 +0930
Subject: Issue: Sending ATT Signed Write Command via btgatt-client
Message-ID: <BD5E516FF3711A41B93DC005170007BB010E5DB57E78@EMBSVR01.ember.local>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Folks,

I would like to Send Signed Write command to modify a characteristic on the Host. It failed into the Error: Failed to initiate write without response procedure

Information on Controller (May be helpful):
root@imx28evk:~# cat /proc/crypto 
name         : ecb(aes)
driver       : ecb-aes-dcp
module       : kernel
priority     : 400
refcnt       : 1
selftest     : passed
type         : ablkcipher
async        : yes
blocksize    : 16
min keysize  : 16
max keysize  : 32
ivsize       : 0
geniv        : <default>

root@imx28evk:~# btmgmt info
Index list with 1 item
hci0:   Primary controller
        addr 1C:BA:8C:86:81:21 version 6 manufacturer 13 class 0x000000
        supported settings: powered connectable fast-connectable discoverable bondable link-security ssp br/edr hs le advertising debug-keys privacy 
        current settings: powered connectable discoverable bondable link-security br/edr le advertising 
        name testbt
        short name 


root@imx28evk:~/tools# btgatt-client -d 00:1B:DC:07:2E:85
Connecting to device... Done
Service Added - UUID: 00001800-0000-1000-8000-00805f9b34fb start: 0x0001 end: 0x000d
Service Added - UUID: 00001801-0000-1000-8000-00805f9b34fb start: 0x0014 end: 0x0016
[GATT client]# GATT discovery procedures complete
[GATT client]# ...
[GATT client]# set-sign-key -c efcdab8967452301efcdab8967452301
[GATT client]# write-value -s -w 0xd 01
Failed to initiate write without response procedure

I tried to trace the error as: 
bt_gatt_client_write_without_response(..) -> bt_att_send(..) -> create_att_send_op(..) -> encode_pdu(..) -> bt_crypto_sign_att(..) -> As att->crypto is NULL it returns false.

I tried to check the reason for att->crypto to be NULL. Found that while initialization of the btgatt-client, under bt_crypto_new() -> crypto->ecb_aes = ecb_aes_setup();. It fails under ecb_aes_setup function. From the output of /proc/crypto, the kernel has the support. I am wondering how to enable the crypto?

Regards,
Ankur.
