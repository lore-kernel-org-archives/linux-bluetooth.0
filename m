Return-Path: <maxk@qualcomm.com>
Message-Id: <5.1.0.14.2.20030722092434.095fc780@unixmail.qualcomm.com>
Date: Tue, 22 Jul 2003 09:26:17 -0700
To: "Daryl Van Vorst" <daryl@wideray.com>, "'Marcel Holtmann'" <marcel@rvs.uni-bielefeld.de>
From: Max Krasnyansky <maxk@qualcomm.com>
Subject: Re: [Bluez-devel] RE: Qualification testing - rfcomm
Cc: "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <001001c347cb$97a39840$1a01010a@baked>
References: <1057913731.1027.11.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <bluez-devel.lists.sourceforge.net>

At 09:43 AM 7/11/2003, Daryl Van Vorst wrote:
>Marcel,
>
>You're right that it doesn't check the error code, it just exits. But that
>doesn't explain why it sends 5 frames, waits for 20 seconds, and then sends
>5 more.  Shouldn't send block?
Yes it should. But only for SO_SNDTIMEO, which is set to 30 sec by default.

Max
