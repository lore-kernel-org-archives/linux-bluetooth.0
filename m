Return-Path: <cyrus@holtmann.org>
Message-ID: <987394.67247.qm@web94902.mail.in2.yahoo.com>
Date: Fri, 7 May 2010 03:34:42 +0530 (IST)
From: Pavan Savoy <pavan_savoy@yahoo.co.in>
Subject: multiple HCI_UART protocols over hci_ldisc
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>, maxk@qualcomm.com
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,=0A=0AI am working on a line discipline which in many respects is=
 similar to the hci_ldisc, but only extended to do plenty of other function=
ality.=0A=0AOne road block which i have hit is to support multiple devices/=
or as Alan Cox puts it "avoid single device limits"=0A=0ASo, in somewhat re=
lation to this, I wanted to ask, If in a system I have 2 UARTs both connect=
ed to BT chips but only from different vendors say TI/HCI-Ll and broadcomm =
with BCSP .. =0A=0ACan I have those 2 protocols on top of HCI-ldisc on diff=
erent UARTs at the same time?=0AIs something like that feasible?=0A=0A
