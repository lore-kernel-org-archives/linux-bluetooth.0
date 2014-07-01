Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <4F821DBD-AE7F-4DBA-8FB9-0F12217F2BC3@holtmann.org>
References: <1403896589-6135-1-git-send-email-scott@netsplit.com>
	<90AEC8D9-5894-4083-AD82-F8D9A8DC1000@holtmann.org>
	<CA+bD78jRm4_Xd3UhhAwnA7jA1H3o2khKcqr3ZtRYmbMcTW4HdA@mail.gmail.com>
	<4F821DBD-AE7F-4DBA-8FB9-0F12217F2BC3@holtmann.org>
Date: Tue, 1 Jul 2014 08:24:15 -0700
Message-ID: <CA+bD78iWPzyTtkvp8V6vPJ86HiO3bvYJTqTU5wS8nht5avao9Q@mail.gmail.com>
Subject: Re: [PATCH] [RFC] doc: Add StartDiscoveryWithOptions
From: Scott James Remnant <scott@netsplit.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Jul 1, 2014 at 3:31 AM, Marcel Holtmann <marcel@holtmann.org> wrote:

> In addition to that, I am thinking that Start Discovery triggered Device Found should be limited to connectable and discoverable events. Unless of course we have them also in Add Device. Then they should be reported out always.
>

This makes sense to me too.

Scott
-- 
Have you ever, ever felt like this?
Had strange things happen?  Are you going round the twist?
