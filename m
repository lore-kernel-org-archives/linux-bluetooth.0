Return-Path: <cyrus@holtmann.org>
Date: Fri, 11 Mar 2011 23:27:58 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Slawomir Bochenski <lkslawek@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 4/4] Add detection of MAP function in OBEX requests
Message-ID: <20110311212758.GA8147@jh-x301>
References: <1299829612-3704-1-git-send-email-lkslawek@gmail.com>
 <1299829612-3704-4-git-send-email-lkslawek@gmail.com>
 <20110311111313.GA20128@jh-x301>
 <AANLkTikJaxmK3pjyptv0xSfb10ivFSu49GdGRTJrXdhP@mail.gmail.com>
 <20110311144855.GA23826@jh-x301>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110311144855.GA23826@jh-x301>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Mar 11, 2011, Johan Hedberg wrote:
> This would be similar to how we handle the telephony driver in BlueZ and
> how the PBAP phonebook back-end is handled in obexd. I'm not saying this
> as justification for the approach but just as a place to look for
> examples. The main justification is to remove one unnecessary
> abstraction layer (the numeric function id) and to remove the need to
> fit each MAP request into the same C function signature (messages_open).
> 
> Trying to fit everything into the same mold forces you to create very
> generic structs like mas_request which then end up needing a
> private_data pointer (for request specific data)

Sorry, I mixed this with some other structs in your code that have this
sort of private data and layering. However, the main point about telling
the back-end which function to call indirectly through an integer
instead of just calling the function directly remains (even if the
function signatures would be the same or very similar).

Johan
