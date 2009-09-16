Return-Path: <cyrus@holtmann.org>
Subject: Re: Install of conf files
From: Marcel Holtmann <marcel@holtmann.org>
To: Peter Hurley <phurley@charter.net>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
In-Reply-To: <4AB0D92A.6000205@charter.net>
References: <4AB0D92A.6000205@charter.net>
Content-Type: text/plain
Date: Wed, 16 Sep 2009 07:54:15 -0700
Message-Id: <1253112855.28416.4.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Peter,

> The following source config files are not installed during make install:
>     audio/audio.conf
>     network/network.conf
>     serial/serial.conf
>     input/input.conf
> Why are main.conf & rfcomm.conf the only conf files that are installed? 
> (I suspect that it's an oversight and these files should be listed as 
> conf_DATA in Makefile.am)

it is no oversight. It is on purpose. The default values of these files
should be fine and we do wanna ensure that. It is up to the users to
modify them.

Regards

Marcel


