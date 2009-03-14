Return-Path: <cyrus@holtmann.org>
Subject: Re: BlueZ AVDTP CLI
From: Marcel Holtmann <marcel@holtmann.org>
To: Danny <demozes@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <1f83d960903061307m67bfa42eg26de6052d1a0a317@mail.gmail.com>
References: <1f83d960903061307m67bfa42eg26de6052d1a0a317@mail.gmail.com>
Content-Type: text/plain
Date: Sat, 14 Mar 2009 07:22:52 +0100
Message-Id: <1237011772.24751.11.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Danny,

> I'm currently developing a CLI utility that should be able to issue
> AVDTP commands using BlueZ.
> In BlueZ I found the functions that issue the commands, but I haven't
> find a way on how to call them - for example, if I want to send the
> the AVDTP_GET_CONFIGURATION_CMD by using avdtp_get_configuration. Is
> there any example/tool available or any documentation? Of course, if
> there's any other way to do it...

for BlueZ we don't have a separate AVDTP layer. It is part of A2DP. So
non of the AVDTP primitives are exported.

Regards

Marcel


