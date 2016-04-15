Return-Path: <linux-bluetooth-owner@vger.kernel.org>
To: linux-bluetooth@vger.kernel.org
From: Stjepan Horvat <stjepan.horvat@swissinnolab.com>
Subject: gatttool --char-write not working from CLI
Message-ID: <5710B6D9.3050607@swissinnolab.com>
Date: Fri, 15 Apr 2016 11:39:37 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi guys.
I have been using gatttool few days now.
It is very great. However i have found a BUG.

When i use:
gatttool -I => connect => char-write-req => WORKS
gatttool --char-write-req => WORKS
gatttool -I => connect => char-write-cmd => WORKS
gatttool --char-write => DOES NOT WORK

is there a reason that the same command has a diferent name in CLI and 
Interactive mode?
What happens is that when i try to execute --char-write from CLI it hangs.

Thanks.
