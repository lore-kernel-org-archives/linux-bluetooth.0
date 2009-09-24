Return-Path: <cyrus@holtmann.org>
Subject: Re: Compiling bluez for python in /usr/local
From: Marcel Holtmann <marcel@holtmann.org>
To: John Frankish <j-frankish@slb.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
In-Reply-To: <6AC5A55546F64545AE996F8200E3AC4E0C80070A@NL0105EXC01V01.eur.slb.com>
References: <6AC5A55546F64545AE996F8200E3AC4E0C80070A@NL0105EXC01V01.eur.slb.com>
Content-Type: text/plain
Date: Thu, 24 Sep 2009 09:55:23 -0700
Message-Id: <1253811323.2931.17.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi John,

> I just compiled bluez-4.53 on a system with python at /usr/local/bin/python - unless I messed up somewhere, it seems simple-agent and the other python scripts still expected to find python at /usr/bin/python.
> 
> Whilst this can be fixed with a symlink, it might be better that the scripts refer to the actual location of python?

they are test scripts and not meant to be installed. So we don't care
about the install path of the Python interpreter.

Regards

Marcel


