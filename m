Return-Path: <cyrus@holtmann.org>
From: Julien COUVRAND <julien.couvrand@stericsson.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Fri, 5 Jul 2013 11:41:15 +0200
Subject: Bluez with uclibc
Message-ID: <747C1E83C744F44E9ACFB89FAEEC2C7B2414E86034@EXDCVYMBSTM005.EQ1STM.local>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I am new to Bluez

Today, I need to cross compile Bluez for arm with uclibc library into Buildroot environment. 
However, I meet some dependencies between bluez-utils package and MMU deactivation due to dBus.

Do you know a way to use Bluez with uclibc library?

Thanks in advance

Regards

Julien
