Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Alain Volmat <avolmat@src.ricoh.co.jp>
To: bluez-devel@lists.sourceforge.net
Reply-To: avolmat@src.ricoh.co.jp
Message-Id: <MJEAZA9US53D8PKVPMIS85DCBA64.3ddb1d27@CASSOULET>
MIME-Version: 1.0
Content-Type: text/plain; charset="shift_jis"
Subject: [Bluez-devel] bluez-kernel: endian problem in hci_core
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: 
	<https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: 
	<http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 20 Nov 2002 14:27:03 +0900

Hi,

I'd like to notify you a problem I've just found in hci_core.c
Well it source of the problem is no endianness but sizeof.
The problem occurs when using BlueZ on a BIG ENDIAN machine.
Due to this problem it, "hcitool dev" doesn't work properly.

When running "hcitool dev", the function
	int hci_get_dev_list(unsigned long arg)
is called in order to fill the hci_dev_list_req structure.
The problem is located at the end, when checking the size 
of data to be copied to user space:
        dl->dev_num = n;
->      size = n * sizeof(struct hci_dev_req) + sizeof(__u16);

        copy_to_user((void *) arg, dl, size);

The function copy_to_user copy dl (struct hci_dev_list_req) to user space.
Since dl can actually contains several hci_dev_req structure the amount
of data to copy is calculated that way:
		size = n * sizeof(struct hci_dev_req) + sizeof(__u16);
The last sizeof(__u16) gives the size of dev_num.

struct hci_dev_req {
        __u16 dev_id;
        __u32 dev_opt;
};

struct hci_dev_list_req {
        __u16  dev_num;
        struct hci_dev_req dev_req[0];  /* hci_dev_req structures */
};


But in fact, due to alignment, event on i386 dev_num will use 4 bytes (not 2 
bytes). The structure hci_dev_req will also use 4 bytes. Which makes that
for example in case of there is only 1 device the size will becomes:
	4 + 8 = 12.
But the variable size is actually set to 10 (8 + 2). (of course sizeof(__u16) is 
2).
In case of little endian, it doesn't make any problem since the LSB is first,
but in case of BIG ENDIAN, the MSB is first so finally the flag indicating that
the device is UP is lost.
As a result, "hcitool dev" will never display devices.

I patched my local code, but in a very dirty way, so please keep me informed
about this issue.

Alain Volmat




-------------------------------------------------------
This sf.net email is sponsored by: To learn the basics of securing 
your web site with SSL, click here to get a FREE TRIAL of a Thawte 
Server Certificate: http://www.gothawte.com/rd524.html
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
