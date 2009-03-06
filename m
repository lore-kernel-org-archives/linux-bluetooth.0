Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Fri, 6 Mar 2009 23:07:38 +0200
Message-ID: <1f83d960903061307m67bfa42eg26de6052d1a0a317@mail.gmail.com>
Subject: BlueZ AVDTP CLI
From: Danny <demozes@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hey,

I'm currently developing a CLI utility that should be able to issue
AVDTP commands using BlueZ.
In BlueZ I found the functions that issue the commands, but I haven't
find a way on how to call them - for example, if I want to send the
the AVDTP_GET_CONFIGURATION_CMD by using avdtp_get_configuration. Is
there any example/tool available or any documentation? Of course, if
there's any other way to do it...

Thanks
