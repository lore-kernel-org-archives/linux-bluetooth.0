Return-Path: <steve.crane@rococosoft.com>
Subject: Re: [Bluez-devel] Service level security for RFCOMM
From: Stephen Crane <steve.crane@rococosoft.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1099024935.10164.11.camel@pegasus>
References: <1099024935.10164.11.camel@pegasus>
Content-Type: text/plain
Message-Id: <1099042277.31284.438.camel@baroque.rococosoft.com>
Mime-Version: 1.0
Date: Fri, 29 Oct 2004 10:31:18 +0100
List-ID: <bluez-devel.lists.sourceforge.net>

On Fri, 2004-10-29 at 05:42, Marcel Holtmann wrote:

> actually it seems that nobody really cares about service level security
> on the RFCOMM layer. Or people are too lazy to send in a patch. However,
> I spent some hours with thinking about it and the core stuff of a small
> framework for providing authentication and encrypt feedback from HCI to
> higher level protocols is finished.

Perhaps this is because no-one except you and Max understands the RFComm
state-machine? :-)

> The problem now is to change the RFCOMM state machine to deal with it
> and reject connections in the failure case. After looking at the state
> machine of RFCOMM, I realized that there are two posibilities when to
> trigger the authentication. One is after we receive the PN CMD and the
> other after the SABM for the specific channel. The specification says
> nothing about that. What are the pros and cons?
> 
> And btw, who is really interested in this feature or needs it?

This is useful (and probably required, I can't remember) for JSR-82.
Especially for people who want to encrypted/authenticated OBEX
connections.

Are you going to do the client-side too?

Steve
-- 
Stephen Crane, Rococo Software Ltd. http://www.rococosoft.com
steve.crane@rococosoft.com +353-1-6601315 (ext 209)
