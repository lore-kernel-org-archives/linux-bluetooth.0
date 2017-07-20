Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: kernel smp.c functions not called by Bluetootl LE controller
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <38d8a549-4335-cf0b-9273-d9ef9b51ac0b@rub.de>
Date: Thu, 20 Jul 2017 20:24:50 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <19307C37-EF03-4E42-AFAD-06855DCB7A3F@holtmann.org>
References: <38d8a549-4335-cf0b-9273-d9ef9b51ac0b@rub.de>
To: Martin Grothe <martin.grothe@rub.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Martin,

> I try to call printk (with priority KERN_ALERT) functions placed in the
> net/bluetooth/smp.c file of my linux kernel 4.9.35 in order to get
> output from specifc functions like:
> 
> static int smp_cmd_public_key()
> 
> But during a pairing with another bluetooth LE device the output of
> these function is never shown in /var/log/kern.log
> 
> Is there any way to verify, that the LE Controller accesses the Security
> Manager Protocol source code the Linux Kernel?
> 
> As far as I understood the Core Specification, in BT 4.0 an above the
> Security Manager is always integrated in the Link Manager, when it comes
> to BR/EDR. But for LE the SM is integrated in the Host part and not the
> Controller. Thus LE Controller should access the smp.c in the Linux kernel.

just run btmon and you see all the security manager exchanges.

Regards

Marcel

