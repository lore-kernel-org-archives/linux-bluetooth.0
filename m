Return-Path: <cyrus@holtmann.org>
Message-Id: <0169718C-C217-4FE9-98D2-97EDECAA8FA8@gmail.com>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
In-Reply-To: <393285.15460.qm@web81808.mail.mud.yahoo.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: Possible to send audio to multiple bluetooth headsets at once?
Date: Sun, 9 Nov 2008 11:35:54 +0200
References: <393285.15460.qm@web81808.mail.mud.yahoo.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Damon,

In theory what you're trying to do should be possible, though you  
might run into bandwidth issues (and there's not much BlueZ can do to  
help with that). However, you do need some configuration file changes  
since the defaults are for one headset only. If you're trying to use  
HSP/HFP add MaxConnections=2 to the [Headset] section in /etc/ 
bluetooth/audio.conf. If you're trying to use A2DP add SBCSources=2 to  
the [A2DP] section of the same file. You might also want to experiment  
with forcing BlueZ to use the profile you want in the case of multi- 
profile headsets. For HSP/HFP you need profile=voice in your .asoundrc  
entries and for A2DP you need profile=hifi.

Johan

