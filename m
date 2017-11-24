Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1511532741.11411.13.camel@hadess.net>
References: <1384017487.3880.42.camel@nuvo> <1511532741.11411.13.camel@hadess.net>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 24 Nov 2017 17:12:00 +0200
Message-ID: <CABBYNZKfZ7mjUsQP+rLRE+RWF8WrYvV6OUvTi5hEaR4AujkmNA@mail.gmail.com>
Subject: Re: [PATCH] obex: Use GLib helper function to manipulate paths
To: Bastien Nocera <hadess@hadess.net>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bastien,

On Fri, Nov 24, 2017 at 4:12 PM, Bastien Nocera <hadess@hadess.net> wrote:
> On Sat, 2013-11-09 at 18:18 +0100, Bastien Nocera wrote:
>> Instead of trying to do it by hand. This also makes sure that
>> relative paths aren't used by the agent.
>
> This is still relevant and applicable.

Id leave as it is if that is not causing any bugs, we do intend to
move away from glib at some point.

-- 
Luiz Augusto von Dentz
