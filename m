Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Message-ID: <1511536737.11411.19.camel@hadess.net>
Subject: Re: [PATCH] obex: Use GLib helper function to manipulate paths
From: Bastien Nocera <hadess@hadess.net>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Fri, 24 Nov 2017 16:18:57 +0100
In-Reply-To: <CABBYNZKfZ7mjUsQP+rLRE+RWF8WrYvV6OUvTi5hEaR4AujkmNA@mail.gmail.com>
References: <1384017487.3880.42.camel@nuvo>
         <1511532741.11411.13.camel@hadess.net>
         <CABBYNZKfZ7mjUsQP+rLRE+RWF8WrYvV6OUvTi5hEaR4AujkmNA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, 2017-11-24 at 17:12 +0200, Luiz Augusto von Dentz wrote:
> Hi Bastien,
> 
> On Fri, Nov 24, 2017 at 4:12 PM, Bastien Nocera <hadess@hadess.net>
> wrote:
> > On Sat, 2013-11-09 at 18:18 +0100, Bastien Nocera wrote:
> > > Instead of trying to do it by hand. This also makes sure that
> > > relative paths aren't used by the agent.
> > 
> > This is still relevant and applicable.
> 
> Id leave as it is if that is not causing any bugs, we do intend to
> move away from glib at some point.

I'm pretty sure that the existing code isn't secure and passing a
relative path as the name will make it break out of the expected
destination folder.
