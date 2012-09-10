Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1347049144.21200.130.camel@aeonflux>
References: <1345272662-2850-1-git-send-email-lucas.demarchi@profusion.mobi>
	<1345272662-2850-7-git-send-email-lucas.demarchi@profusion.mobi>
	<1346961700.21200.116.camel@aeonflux>
	<CABBYNZLZJTcw1Swp-Le25+F8fAweTDy=733PTVffc4sRJbFikQ@mail.gmail.com>
	<1346996989.21200.120.camel@aeonflux>
	<CABBYNZJhaZkixESrBAjaczGpFgysB8CKv12FFw2fLhBG-h-1yg@mail.gmail.com>
	<1347049144.21200.130.camel@aeonflux>
Date: Mon, 10 Sep 2012 16:42:22 +0300
Message-ID: <CABBYNZJow+6joLFi3iB01_W1cFzHJwhr8zaqtreCMspScfBTrw@mail.gmail.com>
Subject: Re: [PATCH BlueZ v3 06/15] gdbus: Implement DBus.Properties.Set method
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Fri, Sep 7, 2012 at 11:19 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
>> Im afraid you will have to go in detail what you want here, the
>> security table seems to be meant for checking privileges in a method
>> level while we can probably extend it for properties and have
>> privileges also in the properties table, but the security table seems
>> to be global not per interface.
>
> you can specify unique integer identifiers as security label to each
> method. We could extend that to each property. The security label is
> used to pick which security callback to call.

Fair enough, but one thing that we might have to consider is that the
label could be dynamic e.g. when a method call has a special security
policy regarding senders (common when we track senders), so perhaps
instead of having the privileges as it is now we need a callback e.g.
check_privileges which takes the sender and returns the
label/privileges needed.

-- 
Luiz Augusto von Dentz
