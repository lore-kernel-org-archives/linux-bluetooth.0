Return-Path: <cyrus@holtmann.org>
Date: Fri, 11 Mar 2011 16:48:55 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Slawomir Bochenski <lkslawek@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 4/4] Add detection of MAP function in OBEX requests
Message-ID: <20110311144855.GA23826@jh-x301>
References: <1299829612-3704-1-git-send-email-lkslawek@gmail.com>
 <1299829612-3704-4-git-send-email-lkslawek@gmail.com>
 <20110311111313.GA20128@jh-x301>
 <AANLkTikJaxmK3pjyptv0xSfb10ivFSu49GdGRTJrXdhP@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <AANLkTikJaxmK3pjyptv0xSfb10ivFSu49GdGRTJrXdhP@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Slawek,

On Fri, Mar 11, 2011, Slawomir Bochenski wrote:
> >> +enum messages_function_id {
> >> +     MFID_INVALID = 0,
> >> +     MFID_SET_NOTIFICATION_REGISTRATION,
> >> +     MFID_GET_FOLDER_LISTING,
> >> +     MFID_GET_MESSAGES_LISTING,
> >> +     MFID_GET_MESSAGE,
> >> +     MFID_SET_MESSAGE_STATUS,
> >> +     MFID_PUSH_MESSAGE,
> >> +     MFID_UPDATE_INBOX,
> >> +};
> >
> > Since "function" here doesn't seem to be referring to a C function but
> > to the type of request, could you call it e.g. request_type instead? Is
> > there a reason you you want to have this enum instead of e.g. storing
> > the original value of the type header?
>
> Function here refers to function as used in MAP specification (see
> chapter 5: Message Access Profile Functions). Functions in MAP are an
> abstraction above OBEX requests and types. There is one case where one
> type is used for two functions (the difference is whether it is GET or
> PUT request).
> 
> In 3 (of 9 total) cases type is used solely for selecting function, as
> there is no real object transmitted (well, to be exact the body in
> this cases consist of single filler byte).
> 
> And those MAP functions also accept input parameters and return output
> ones, so the name "function" is quite appropriate.
> 
> As checking for this MAP function called is needed in more places it
> is convenient to store it as a number instead of doing expensive
> string comparison each time.

Ok, this makes sense (this was a good chance for me to catch up on the
MAP spec ;). However only as far as the MAP core is concerned. On the
MAP back-end side the only relevant purpose of the id seems to be to
pick the right internal function to call. Therefore, I think it'd make
more sense to have these request specific functions exported by the
back-end and have the MAP core call them directly.

This would be similar to how we handle the telephony driver in BlueZ and
how the PBAP phonebook back-end is handled in obexd. I'm not saying this
as justification for the approach but just as a place to look for
examples. The main justification is to remove one unnecessary
abstraction layer (the numeric function id) and to remove the need to
fit each MAP request into the same C function signature (messages_open).

Trying to fit everything into the same mold forces you to create very
generic structs like mas_request which then end up needing a
private_data pointer (for request specific data) and all this layering
just increases the overall complexity of the code.

Johan
