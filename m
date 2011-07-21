Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CA+i+Aw2wQBk5cc4w9Xk5KQsKGVpM-hWU2hBjbaFcE+BBKDKhjQ@mail.gmail.com>
References: <1311245799-8662-1-git-send-email-lkslawek@gmail.com>
	<CA+i+Aw2wQBk5cc4w9Xk5KQsKGVpM-hWU2hBjbaFcE+BBKDKhjQ@mail.gmail.com>
Date: Thu, 21 Jul 2011 14:53:16 +0300
Message-ID: <CABBYNZ+5FoUfKDGAy=entXjR855fSxSGPA+tv-gOO5HyMm_MhQ@mail.gmail.com>
Subject: Re: [PATCH obexd] Fix finding mime driver by type
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Slawomir Bochenski <lkslawek@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Jul 21, 2011 at 2:07 PM, Slawomir Bochenski <lkslawek@gmail.com> wrote:
> On Thu, Jul 21, 2011 at 12:56 PM, Slawomir Bochenski <lkslawek@gmail.com> wrote:
>> IrOBEX specification chap. 2.2.3 states that the Type header is an ASCII
>> null-terminated string which values are case insensitive (as it is also
>> defined by RFC 1521).
>
> s/which/whose/
>
> --

Nice catch, ack.

-- 
Luiz Augusto von Dentz
