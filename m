Return-Path: <cyrus@holtmann.org>
From: kjonca@o2.pl (Kamil =?iso-8859-2?Q?Jo=F1ca?=)
To: linux-bluetooth@vger.kernel.org
Subject: How to pair device from CLI?
Date: Fri, 28 Dec 2012 01:23:18 +0100
Message-ID: <871uebt47d.fsf@alfa.kjonca>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


I don't know if this is proper list, but I cannot find any (active) bluez users
list. 

I tried to pair my phone:

--8<---------------cut here---------------start------------->8---
$hcitool scan                         
Scanning ...
        D4:E8:B2:AA:15:FA       theta

$bluez-simple-agent hci0 D4:E8:B2:AA:15:FA
RequestPasskey (/org/bluez/3086/hci0/dev_D4_E8_B2_AA_15_FA)
Enter passkey: 0000
Creating device failed: org.bluez.Error.AuthenticationFailed: Authentication Failed
--8<---------------cut here---------------end--------------->8---

What do I should check? (s)trace?

Distribution is pretty fresh debian sid.

-- 
http://blogdebart.pl/2012/06/24/hiena/
  We're overpaying him, but he's worth it. -Samuel Goldwyn
