Return-Path: <cyrus@holtmann.org>
Message-ID: <4BE2947F.9030103@greffrath.com>
Date: Thu, 06 May 2010 12:05:51 +0200
From: Fabian Greffrath <fabian@greffrath.com>
MIME-Version: 1.0
To: Serhiy Kachaniuk <serzholino@gmail.com>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [bugreport]
References: <p2q793f89501005052222u4393c8dfhb55bea4454c454b9@mail.gmail.com>	 <4BE270EE.5080306@greffrath.com> <y2t793f89501005060301t9bdc8c73v266a798160027d4d@mail.gmail.com>
In-Reply-To: <y2t793f89501005060301t9bdc8c73v266a798160027d4d@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Am 06.05.2010 12:01, schrieb Serhiy Kachaniuk:
> Interesting moment: when run without sudo with version 4.60 it shows
> name, but prints error on getting class of device:

Maybe a stupid question, but do you have an application like GNOME's 
bluetooth applet running (that keeps the shared lib in memory) while 
switching bluez versions?
