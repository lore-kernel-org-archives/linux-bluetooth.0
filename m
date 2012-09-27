Return-Path: <cyrus@holtmann.org>
Date: Thu, 27 Sep 2012 10:42:06 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: =?iso-8859-1?Q?Jo=E3o?= Paulo Rechi Vita <jprvita@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ v7 1/9] core: Mutually exclude concurrent
 connections
Message-ID: <20120927074206.GB9610@x220>
References: <1348594686-26221-1-git-send-email-jprvita@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1348594686-26221-1-git-send-email-jprvita@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Sep 25, 2012, João Paulo Rechi Vita wrote:
> Since controllers don't support more than one ongoing connection
> procedure at the same time, new connection attempts needs to yield if
> there is an ongoing connection procedure already.

Simply based on this description the first question that comes to mind
is wouldn't this be better handled on the kernel side? After all other
processes besides bluetoothd (like obexd) are also capable of initiating
connections and we can't control that within bluetoothd.

Johan
