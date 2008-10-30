Return-Path: <cyrus@holtmann.org>
Date: Fri, 31 Oct 2008 01:30:22 +0530 (IST)
From: pavan_savoy@indiatimes.com
To: <linux-bluetooth@vger.kernel.org>
Message-ID: <1307132544.125351225396822791.JavaMail.root@mbv7.indiatimes.com>
Subject: Creation of AF_BLUETOOTH socket with HCI_DEV__REG
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Can there be a scenario where an application can do a hci_open_dev and use the Bluetooth Socket, without actually the HCID recieving the HCI_DEV_REG ?

Say a scenario where in only hciattach has been done [UART device] and HCID isn't run at all. Then would any other application make use of the hci_open_dev calls ?


Thanks & Regards,
Pavan Savoy.


--
Hyundai to launch the i20 in India. Catch the exclusive preview on ZigWheels.com
http://www.zigwheels.com/b2cam/newsDetails.action?name=Emb11_20080731&path=/INDT/News/Emb11_20080731&page=1&pagecount=2&utm_source=indmail&utm_medium=footer&utm_content=tracking&utm_campaign=Nletter_07oct2008_ZW
