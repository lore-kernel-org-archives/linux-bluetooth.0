Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1334786904-26282-1-git-send-email-jprvita@openbossa.org>
References: <1334786904-26282-1-git-send-email-jprvita@openbossa.org>
From: Arik Nemtsov <arik@wizery.com>
Date: Thu, 19 Apr 2012 12:45:23 +0300
Message-ID: <CA+XVXfeJ254A2kVTvpR6GyjAJvdNC_G6=840C9aDQjbeT+y_cQ@mail.gmail.com>
Subject: Re: [RFC v2 00/16] HoG plugin
To: =?ISO-8859-1?Q?Jo=E3o_Paulo_Rechi_Vita?= <jprvita@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org, claudio.takahasi@openbossa.org,
	Ido Yariv <ido@wizery.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

2012/4/19 João Paulo Rechi Vita <jprvita@openbossa.org>:
> Second draft of the HoG plugin. Code went through a lot of refactoring and is
> much cleaner now. The report descriptor parsing (to get the report id) is
> hackish and it doesn't support more than one device simultaneosly, probably
> due to a kernel bug (reports come from the wrong socket). We're investigating
> it.

Maybe this patch can help you? We encountered a similar issue with
multiple devices.

http://permalink.gmane.org/gmane.linux.bluez.kernel/22397

Arik
