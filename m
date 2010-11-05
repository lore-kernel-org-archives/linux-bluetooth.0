Return-Path: <cyrus@holtmann.org>
Date: Fri, 5 Nov 2010 11:18:09 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Daniel =?iso-8859-1?Q?=D6rstadius?= <daniel.orstadius@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix add disconnect watch in connecting state
Message-ID: <20101105091808.GA31519@jh-x301>
References: <AANLkTikyPtikmH=ep2va2iLke9NoteTr5wpThfR6v=vf@mail.gmail.com>
 <20101104181606.GA15745@jh-x301>
 <AANLkTimKWv3XcJ6qfJK6QNCY38vza+Nj12cGfdAELXxu@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <AANLkTimKWv3XcJ6qfJK6QNCY38vza+Nj12cGfdAELXxu@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Daniel,

On Fri, Nov 05, 2010, Daniel Örstadius wrote:
> On Thu, Nov 4, 2010 at 8:16 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> > This doesn't seem quite right to me. Aren't you now adding a disconnect
> > callback twice: once for CONNECTING and a second time for CONNECTED? It
> > seems like you should only add it when new_state == CONNECTING, right?
> >
> 
> Yes, that seems right, attaching updated patch.

Thanks. The patch is now in the upstream tree.

Johan
