Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20110311111313.GA20128@jh-x301>
References: <1299829612-3704-1-git-send-email-lkslawek@gmail.com>
	<1299829612-3704-4-git-send-email-lkslawek@gmail.com>
	<20110311111313.GA20128@jh-x301>
Date: Fri, 11 Mar 2011 12:40:05 +0100
Message-ID: <AANLkTikJaxmK3pjyptv0xSfb10ivFSu49GdGRTJrXdhP@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] Add detection of MAP function in OBEX requests
From: Slawomir Bochenski <lkslawek@gmail.com>
To: Slawomir Bochenski <lkslawek@gmail.com>,
	linux-bluetooth@vger.kernel.org
Cc: Johan Hedberg <johan.hedberg@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

>> +enum messages_function_id {
>> +     MFID_INVALID = 0,
>> +     MFID_SET_NOTIFICATION_REGISTRATION,
>> +     MFID_GET_FOLDER_LISTING,
>> +     MFID_GET_MESSAGES_LISTING,
>> +     MFID_GET_MESSAGE,
>> +     MFID_SET_MESSAGE_STATUS,
>> +     MFID_PUSH_MESSAGE,
>> +     MFID_UPDATE_INBOX,
>> +};
>
> Since "function" here doesn't seem to be referring to a C function but
> to the type of request, could you call it e.g. request_type instead? Is
> there a reason you you want to have this enum instead of e.g. storing
> the original value of the type header?
Function here refers to function as used in MAP specification (see
chapter 5: Message Access Profile Functions). Functions in MAP are an
abstraction above OBEX requests and types. There is one case where one
type is used for two functions (the difference is whether it is GET or
PUT request).

In 3 (of 9 total) cases type is used solely for selecting function, as
there is no real object transmitted (well, to be exact the body in
this cases consist of single filler byte).

And those MAP functions also accept input parameters and return output
ones, so the name "function" is quite appropriate.

As checking for this MAP function called is needed in more places it
is convenient to store it as a number instead of doing expensive
string comparison each time.

-- 
Slawomir Bochenski
