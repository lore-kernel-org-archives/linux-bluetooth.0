Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20090308210236.2eafb651@symphony>
References: <20090308183155.2d68c6e4@symphony>
	 <20090308210236.2eafb651@symphony>
Date: Mon, 9 Mar 2009 10:10:10 -0300
Message-ID: <2d5a2c100903090610o42d0378avde2d7c51d60a101a@mail.gmail.com>
Subject: Re: bnep should not depend on IPv6
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: James Le Cuirot <chewi@aura-online.co.uk>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi James,

On Sun, Mar 8, 2009 at 6:02 PM, James Le Cuirot <chewi@aura-online.co.uk> wrote:
> On Sun, 8 Mar 2009 18:31:55 +0000
> James Le Cuirot <chewi@aura-online.co.uk> wrote:
>
>> I looked at the source and traced this
>> back to network/connection.c where there are two calls to socket()
>> with AF_INET6 given as an argument.
>
> Sorry, I actually meant network/common.c.

Good catch I will have a look at it.


-- 
Luiz Augusto von Dentz
Engenheiro de Computação
