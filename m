Return-Path: <thomae@ei.tum.de>
Message-Id: <3F65DB01.9030802@ei.tum.de>
Date: Mon, 15 Sep 2003 17:30:09 +0200
From: Matthias Thomae <thomae@ei.tum.de>
MIME-Version: 1.0
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>,
   Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
Subject: bfusb 1.1 firmware loading and rc-scripts
References: <3F65D3E6.60307@ei.tum.de>
In-Reply-To: <3F65D3E6.60307@ei.tum.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
List-ID: <bluez-users.lists.sourceforge.net>

Hello Marcel, list,

since upgrading from bfusb 1.0 to 1.1 I have problems creating bluetooth 
connections at system start form the rc-scripts on a debian/unstable 
system, such as PAN or CMTP connections.

I think this is because the old bfusb version was returning only when 
the firmware has finished loading into the dongle (which takes a few 
seconds), whereas the new version returns immediately and loads the 
firmware in the background. Is this correct? When putting "sleep 10" in 
one of the rc scripts, it works as before.

Is there a way to detect when the firmware loading is finished, or would 
you consider to change back to the old behaviour?

Regards.
Matthias
