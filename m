Return-Path: <cyrus@holtmann.org>
Message-ID: <54B356B8.1030208@farce.de>
Date: Mon, 12 Jan 2015 14:08:08 +0900
From: Stefan Wiehler <sephalon@farce.de>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: Replacement for rfcomm.conf
References: <54B272A8.4000105@farce.de> <61857A98-EF57-4478-83B8-74DD691164ED@holtmann.org>
In-Reply-To: <61857A98-EF57-4478-83B8-74DD691164ED@holtmann.org>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

 > just create an init script of systemd service file and run the rfcomm
 > bind command manually. As long as you know the remote BD_ADDR of the
 > device you want to connect to and the RFCOMM channel of the SSP
 > service on that device, you can create a binding. No local controller
 > has to be present to create a RFCOMM binding.

How embarrassing that I didn't realize that by myself. Indeed this was
the simplest solution for the problem. Thank you for your help!

Kind regards,

Stefan Wiehler
