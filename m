Return-Path: <linux-bluetooth-owner@vger.kernel.org>
To: linux-bluetooth@vger.kernel.org
From: Ian Molton <ian@mnementh.co.uk>
Subject: what to do with brcm_patchram_plus?
Message-ID: <7cef65c9-b831-b0bb-8029-38fcd99e75aa@mnementh.co.uk>
Date: Sun, 25 Jun 2017 17:26:56 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,


I've been attempting to get bluetooth working on a broadcom 43430 chip, 
on 4.12-rc6.

I've got it to work, at least somewhat.

I'm using:

# brcm_patchram_plus --patchram /lib/firmware/bcm/bcm43430a1.hcd 
--no2bytes --tosleep 1000 --bd_addr <my_addr> /dev/ttymxc1


# hciattach /dev/ttymxc1 any


As I understand it, brcm_patchram_plus just loads firmware into the 
chip, and hciattach is just hooking the hci-uart driver to the serial 
port as a line discipline?

Is this the correct approach? is there a better way to get the firmware 
loaded?

I've also read that btattach should be used instead of hciattach? is 
this the case?



-Ian
