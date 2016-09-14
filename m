Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20160914155910.GC98438@redhat.com>
References: <20160914155910.GC98438@redhat.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 14 Sep 2016 19:52:11 +0300
Message-ID: <CABBYNZLrgvqSDu-CPAWek02SOFAKLzKdg5pQdQfU+vw-hWgL1g@mail.gmail.com>
Subject: Re: using d-bus api to set security level
To: Don Zickus <dzickus@redhat.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Don,

On Wed, Sep 14, 2016 at 6:59 PM, Don Zickus <dzickus@redhat.com> wrote:
> Hi,
>
> I am trying to find the equivalent of using gatttool's --sec-level when
> writing a python script to connect to an LE device over the d-bus API.
>
> It seems like I have to set the Characteristic correctly.  But I am missing
> something obvious when looking through the doc/ api files.
>
> Can someone point me to the right spot?  Thanks!

You can call Device1.Pair if you want to authenticate, once the LTK is
exchanged it will be used automatically in the next connections.


-- 
Luiz Augusto von Dentz
