Return-Path: <cyrus@holtmann.org>
Message-ID: <508D6672.8000009@globaledgesoft.com>
Date: Sun, 28 Oct 2012 22:38:02 +0530
From: Ajay <ajay.kv@globaledgesoft.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: BLE issue:  Start_LE_Encryption fails
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,
	I am getting le_long_term_key_negative reply  from the remote device , 
on sending le_start_encryption . I am testing this with 2 ubuntu 
machines(3.2.5) with IOGEAR dual mode dongles .
	 I did  pairing  using blueman and  got corresponding link key 
from(/var/lib/bluetooth) . But i doubt, this key is specific to BR/EDR 
not for LE controller , since hcidump is not showing any packets related 
to smp .
    so please suggest me a way to do pairing using SMP and LE specific
-- 
Thanks & regards

  AJAY KV
  GlobalEdge software Ltd
  8892753703
