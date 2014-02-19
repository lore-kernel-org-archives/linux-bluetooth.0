Return-Path: <cyrus@holtmann.org>
Date: Wed, 19 Feb 2014 06:15:08 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Petri Gynther <pgynther@google.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] core: Fix device_get_name()
Message-ID: <20140219041508.GA26709@x220.p-661hnu-f1>
References: <20140219004413.4361A1005F0@puck.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140219004413.4361A1005F0@puck.mtv.corp.google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Petri,

On Tue, Feb 18, 2014, Petri Gynther wrote:
> Fix device_get_name() to null-terminate the name string it returns.
> Modify all callers as needed.
> ---
>  plugins/wiimote.c       | 1 -
>  profiles/input/device.c | 2 +-
>  src/device.c            | 5 ++++-
>  3 files changed, 5 insertions(+), 3 deletions(-)

Applied. Thanks.

Johan
