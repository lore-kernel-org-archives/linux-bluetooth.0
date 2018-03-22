Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: bugzilla-daemon@bugzilla.kernel.org
To: linux-bluetooth@kernel.org
Subject: [Bug 198953] hci_bcm: Streamline runtime PM code    change for 4.16
 kernel breaks bluetooth on ASUS T100TA
Date: Thu, 22 Mar 2018 16:31:24 +0000
Message-ID: <bug-198953-62941-105PPCN3eW@https.bugzilla.kernel.org/>
In-Reply-To: <bug-198953-62941@https.bugzilla.kernel.org/>
References: <bug-198953-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=198953

--- Comment #27 from Robert R. Howell (rhowell@uwyo.edu) ---
Hi Hans

I've tested your new NVRAM patch on my T100TA, T100TAM, and Toshiba Encore and
it works on all three.  If the ...sdio.txt file is present it uses that,
otherwise it successfully gets the information from NVRAM.

There was one side effect you may want to know about.  Originally I had my
kernel built with the CONFIG_FW_LOADER_USER_HELPER_FALLBACK option set.  It
turns out that when that option is set your NVRAM patch causes an additional 60
second delay in WiFi coming up, as the system waits for some timeout to occur
during the "firmware" load.  That is in addition to another 60 second delay
which was introduced by CLM related changes in kernel 4.15, as I mentioned in
my other bug report at <https://bugzilla.kernel.org/show_bug.cgi?id=198089>. 
But both 60 second delays disappear when I build a kernel without
CONFIG_FW_LOADER_USER_HELPER_FALLBACK being set, and apparently in most
distributions, that option is NOT set.

In testing that NVRAM patch I discovered another issue with the brcmfmac
driver, in that after unloading it with "modprobe -r brcmfmac", reloading it
with "modprobe brcmfmac" often fails.  However while your patch MAY affect the
details of what happens, sort of problem seems to be present at least from 4.15
onward, and perhaps earlier.  The problem may also be intermittent, so sorting
this out has become difficult.  With your patch in use, the failure usually
occurs as follows.  But something like this (perhaps with slightly different
messages) often goes wrong without the NVRAM patch too.  The only way to clear
this error is to reboot, so that also makes debugging difficult.  I'll let you
know if I can sort out the pattern.

[  135.464064] brcmfmac: brcmf_fw_map_chip_to_name: using
brcm/brcmfmac43241b4-sdio.bin for chip 0x004324(17188) rev 0x000005
[  135.464167] usbcore: registered new interface driver brcmfmac
[  140.718849] brcmfmac: brcmf_sdio_bus_stop: Failed to force clock for F2: err
-16

Since in normal use I typically don't need to unload and reload the driver,
usually this bug doesn't cause a problem.

-- 
You are receiving this mail because:
You are the assignee for the bug.