Return-Path: <cyrus@holtmann.org>
Sender: =?UTF-8?Q?Cristian_Rodr=C3=ADguez?= <cr@cristianrodriguez.net>
Message-ID: <50D8888E.3010308@opensuse.org>
Date: Mon, 24 Dec 2012 13:53:34 -0300
From: =?UTF-8?B?Q3Jpc3RpYW4gUm9kcsOtZ3Vleg==?= <crrodriguez@opensuse.org>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] lib: use %m instead of strerror
References: <1356362730-16557-1-git-send-email-crrodriguez@opensuse.org> <1356367748.29264.43.camel@aeonflux>
In-Reply-To: <1356367748.29264.43.camel@aeonflux>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon 24 Dec 2012 01:49:08 PM CLST, Marcel Holtmann wrote:

> how does this work on uClibc and other C libraries. Is %m these days
> generally supported?

according to google uclibc support %m .. which is currently part of 
POSIX.
