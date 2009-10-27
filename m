Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Local out of band properties
From: Bastien Nocera <hadess@hadess.net>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
In-Reply-To: <f9d4bd30910261504l577041d7y72f7a68b9a9753e9@mail.gmail.com>
References: <f9d4bd30910261504l577041d7y72f7a68b9a9753e9@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Date: Tue, 27 Oct 2009 12:42:54 +0000
Message-Id: <1256647374.2367.82.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, 2009-10-26 at 20:04 -0200, Claudio Takahasi wrote:
> Hi,
> 
> this is the first step to support secure simple pairing using out of
> band mechanism(NFC, USB, ..).
> 
> First it is necessary export to applications a method to retrieve the data
> that will be exchanged using out of band mechanism. "Hash" and "Randomizer"
> properties were added in GetProperties method and PropertyChanged signal.
> 
> git://git.infradead.org/users/cktakahasi/bluez.git oob-local
> 
> Comments? Useless for now?
> 
> 
> 
> The second part of oob is set the exchanged oob data in the device struct
> and reply the oob data when the host controller sends "Remote OOB Data
> Request Event".
> 
> Initial proposal is here:
> git://git.infradead.org/users/cktakahasi/bluez.git  oob-remote
> It works, but we need to discuss the API.

http://git.infradead.org/users/cktakahasi/bluez.git/blobdiff/ece9ea1c2e50697ed9b57fb53ff681d20b317610..d8a359f5e90879468ec1291961f9f60c62a52ac2:/doc/adapter-api.txt
Same typo in both descriptions.

Is there any way to request that the adapter refresh the
hash/randomizer, or would that happen automatically when the data is
actually used?

Also, can the values be used independently of each other? In that case,
it might make sense to have them both concatenated inside a one and only
property.

Finally, as you say you've tested this, which hardware did you use for
testing? I know about the Nokia 6212 with NFC, but couldn't find a
suitable NFC reader to go with it.

Cheers


