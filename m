Return-Path: <philip@lawatsch.at>
Message-ID: <412CED9A.2070405@lawatsch.at>
Date: Wed, 25 Aug 2004 21:50:50 +0200
From: Philip Lawatsch <philip@lawatsch.at>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] Limit communication to serveral devices
References: <412C9803.6080306@lawatsch.at> <1093443880.537.0.camel@pegasus>
In-Reply-To: <1093443880.537.0.camel@pegasus>
Content-Type: text/plain; charset=us-ascii; format=flowed
List-ID: <bluez-users.lists.sourceforge.net>

Marcel Holtmann wrote:

> you must change the code of the accept routine in the RFCOMM server
> program that you are using.

This is not quite what I want. I'd like to limit this at lowest layer 
possible. Actually I'm starting to wonder that there seems to be 
_nothing_ to that, which, at least I think so, poses a potential 
security risk.


kind regards Philip
