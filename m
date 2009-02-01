Return-Path: <cyrus@holtmann.org>
Subject: Re: streaming via a2dpd and using soundcard simultaneously?
From: Marcel Holtmann <marcel@holtmann.org>
To: Odysseus Flappington <deriziotis@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <5eee8c670902010554h67d099e8xe2ec1e196dbb62f4@mail.gmail.com>
References: <5eee8c670902010554h67d099e8xe2ec1e196dbb62f4@mail.gmail.com>
Content-Type: text/plain
Date: Sun, 01 Feb 2009 17:50:23 +0100
Message-Id: <1233507023.4809.0.camel@californication>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alex,

> Is it possible to stream all audio on my linux system to a set of
> bluetooth speakers via a2dpd, while at the same time, having the same
> audio coming out of the soundcard and through a pair of wired
> speakers?

we are not using a2dpd anymore. It is a plugin of bluetoothd now and
when using a system like PulseAudio then it is possible.

Regards

Marcel


