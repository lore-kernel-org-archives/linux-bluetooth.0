Return-Path: <cyrus@holtmann.org>
Date: Wed, 19 May 2010 16:05:04 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH v3] Bluetooth: Add blacklist support for incoming
 connections
Message-ID: <20100519140503.GA6822@jh-x301>
References: <1274181632-29873-1-git-send-email-johan.hedberg@gmail.com>
 <20100519081037.GE6219@vigoh>
 <20100519082205.GA18772@jh-x301>
 <20100519084715.GA11110@vigoh>
 <AANLkTimdw00tjbCHK52SNF9FGJjLVHR35f44dX_bzj__@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AANLkTimdw00tjbCHK52SNF9FGJjLVHR35f44dX_bzj__@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Wed, May 19, 2010, Luiz Augusto von Dentz wrote:
> @ Johan, Blocked does supersedes Trusted right?

Right. What also happens when you set Blocked to False is that all the
device drivers are unloaded for that device. When Blocked goes back to
true the drivers get probed again.

> Maybe we should rework those properties (deprecate them?) to something
> like Authorization which takes a string where lets say can assume
> these values: "deny" ("block"), "ask" or "allow".

Sounds like an interesting idea, but I'm not completely convinced about
it since the properties act on different layers. Currently authorization
is on the profile layer and is completely optional for a profile
implementation (i.e. it needs to call btd_request_authorization
(bluetoothd plugin) or RequestAuthorization (D-Bus) whereas there's no
way to skip the blocked check in the kernel. I.e. if we'd have a unified
property, the value "blocked" would be unconditional but "ask" wouldn't
always mean "ask": it would only happen once the connection reaches the
profile level and only for the profiles that actually enforce
authorization.

Johan
