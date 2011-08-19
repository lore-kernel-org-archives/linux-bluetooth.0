Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAFVnFZafZxVJtZ1bSKSd1nSOSYBMnG9B_xs=+RqxR6OWpHUQog@mail.gmail.com>
References: <CAFVnFZafZxVJtZ1bSKSd1nSOSYBMnG9B_xs=+RqxR6OWpHUQog@mail.gmail.com>
Date: Fri, 19 Aug 2011 22:36:49 +0200
Message-ID: <CA+i+Aw2_ZJfBbqukwVXhrOeXTpRENTNPu+225zCLRfanM7c5eQ@mail.gmail.com>
Subject: Re: MAP support in Obexd
From: Slawomir Bochenski <lkslawek@gmail.com>
To: "spaceindaver0@gmail.com" <spaceindaver0@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, Aug 19, 2011 at 8:06 PM, spaceindaver0@gmail.com
<spaceindaver0@gmail.com> wrote:
> Hi All,
>
> I am a student enetering my final year of study and would like to
> contribute as part of my Final Year Project. I would like to implement
> the MAP profile in obexd as I have an interest in developing for
> bluetooth (and have done work in IVI where this would be usefull).
>
> Is anyone aware of anybody currently doing work in this area?
Yes, the work on MAP server is ongoing. I'm developing a protocol
infrastructure and Bartosz Szatkowski is working on backend for
accessing messages stored in GNOME Tracker). Most of the functionality
has been already coded but out of upstream tree and now it's being
refactored to the form appropriate for upstreaming. You can already
see small parts of it in obexd git tree (plugins/messages.h,
plugins/mas.c, plugins/messages-*.c)

-- 
Slawomir Bochenski
