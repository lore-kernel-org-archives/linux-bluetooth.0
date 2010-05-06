Return-Path: <cyrus@holtmann.org>
Message-ID: <4BE297E6.1010406@greffrath.com>
Date: Thu, 06 May 2010 12:20:22 +0200
From: Fabian Greffrath <fabian@greffrath.com>
MIME-Version: 1.0
To: Bastien Nocera <hadess@hadess.net>
CC: Serhiy Kachaniuk <serzholino@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [bugreport]
References: <p2q793f89501005052222u4393c8dfhb55bea4454c454b9@mail.gmail.com>	 <4BE270EE.5080306@greffrath.com>	 <y2t793f89501005060301t9bdc8c73v266a798160027d4d@mail.gmail.com>	 <4BE2947F.9030103@greffrath.com> <1273140706.13354.1376.camel@localhost.localdomain>
In-Reply-To: <1273140706.13354.1376.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Am 06.05.2010 12:11, schrieb Bastien Nocera:
> gnome-bluetooth doesn't use libbluetooth, and a newly started app would
> be using the library that's on disk anyway, not the one in memory if
> they were different (you could see that in lsof which would show an
> older running application as using the library with a "(deleted)"
> comment).

Alright, thanks for the clarification. ;)
