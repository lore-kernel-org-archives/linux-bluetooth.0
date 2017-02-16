Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: Re: Difference between the bluetooth HCI Types
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAEd-yTSatpXgNqWQbq4a=F+qqQmUYYDG+A=Qshrz+QWdvd_+_g@mail.gmail.com>
Date: Thu, 16 Feb 2017 17:16:03 +0100
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <4613A157-6291-46EC-86E4-A4673DFC9454@holtmann.org>
References: <CAEd-yTSatpXgNqWQbq4a=F+qqQmUYYDG+A=Qshrz+QWdvd_+_g@mail.gmail.com>
To: Sinthu Raja M <sinthu.raja@mistralsolutions.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Raja,

> I am working on the Bluez stack, when I gave a command hciconfig i got the
> following result
> 
> hciconfig
> hci0: Type: Primary  Bus: UART
> BD Address: 72:8E:6C:AB:DD:A4  ACL MTU: 1021:8  SCO MTU: 64:1
> 
> Can anyone please brief me about the Primary type and the ED/BR type.

they are the same. It used to be called BR/EDR, but actually a better description is Primary. Since these days it includes LE as well. Also the specification differentiates between Primary and AMP controllers.

Regards

Marcel

