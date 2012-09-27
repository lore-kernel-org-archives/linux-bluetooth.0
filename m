Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120927074206.GB9610@x220>
References: <1348594686-26221-1-git-send-email-jprvita@openbossa.org> <20120927074206.GB9610@x220>
From: Joao Paulo Rechi Vita <jprvita@openbossa.org>
Date: Thu, 27 Sep 2012 17:31:05 -0300
Message-ID: <CAAngNMZka=wBQTn1y5bFPaWwUog+p-qugbC9cPnUkD-ygLNbDg@mail.gmail.com>
Subject: Re: [PATCH BlueZ v7 1/9] core: Mutually exclude concurrent connections
To: Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Johan,

On Thu, Sep 27, 2012 at 4:42 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi,
>
> On Tue, Sep 25, 2012, João Paulo Rechi Vita wrote:
>> Since controllers don't support more than one ongoing connection
>> procedure at the same time, new connection attempts needs to yield if
>> there is an ongoing connection procedure already.
>
> Simply based on this description the first question that comes to mind
> is wouldn't this be better handled on the kernel side? After all other
> processes besides bluetoothd (like obexd) are also capable of initiating
> connections and we can't control that within bluetoothd.
>

This whole series implements the General Connection Establishment
Procedure (GCEP), as described in the core spec. According to this
procedure, when a new connection to a remote device is requested, a
scan is initiated and only when an advertise from this device is seen
the connect command is sent to the controller.

We could implement the whole procedure inside the kernel, but on the
discussions we (me, André, Vinicius and Claudio) had, it seems that
some changes on the socket api (related to the l2cap socket timeout)
will be needed to accommodate that. Also, it is still  an open
question if we can make use of the controller white-list to improve LE
connections management, and in this case it wouldn't make sense to
have the GCEP in the kernel.

And more important, having the GCEP in userspace is a big improvement
over what we have now. Current upstream code doesn't handle LE
re-connections at all, so if a remote device disconnects to save power
(which all HoG devices we have do), we're starting the GCEP to
re-connect to it. We can discuss a way to better support multiple
processes opening LE sockets, but I don't think having this code
upstream will hurt right now.

-- 
João Paulo Rechi Vita
Openbossa Labs - INdT
