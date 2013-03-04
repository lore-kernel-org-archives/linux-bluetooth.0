Return-Path: <cyrus@holtmann.org>
Message-ID: <5134D134.6020101@oss.bmw-carit.de>
Date: Mon, 04 Mar 2013 17:52:04 +0100
From: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>
MIME-Version: 1.0
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH 2/2] obexd: Add support for retrieving messages in fractions
References: <1362064124-29787-1-git-send-email-christian.fetzer@oss.bmw-carit.de> <1362064124-29787-3-git-send-email-christian.fetzer@oss.bmw-carit.de> <CABBYNZKQV8jJFeCPB_t+_Lv1FgPQYu72zj-nmXoatAZkA-A_tg@mail.gmail.com> <CABBYNZLvDKP18EjgVqa9r4Dt7rTBcDEEz0jv8e6fs9LUSOnwaw@mail.gmail.com>
In-Reply-To: <CABBYNZLvDKP18EjgVqa9r4Dt7rTBcDEEz0jv8e6fs9LUSOnwaw@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On 03/01/2013 02:13 PM, Luiz Augusto von Dentz wrote:
> So from the discussion the IRC yesterday I think we can have this 
> transparently handled by the transfer, we can perhaps add 
> Suspend/Resume and suspended state API to Transfer interface which 
> probably in this case should auto suspend if FractionDelivery is set 
> so the application has to resume to get the parts but they all belong 
> to the same transfer and are saved in the same file. -- Luiz Augusto 
> von Dentz -- To unsubscribe from this list: send the line "unsubscribe 
> linux-bluetooth" in the body of a message to majordomo@vger.kernel.org 
> More majordomo info at http://vger.kernel.org/majordomo-info.html 

I'll try to explain the fractioned download in details and some use 
cases, hopefully that helps choosing a proper API.
The whole fraction mechanism is a special case, because most of phones 
do not support this.


Use case
----------

Fractioned messages are used by some email push-services. Only the first 
small part of the message is available on the phone.
The rest of the message has to be downloaded from the internet / 
network. Which is slow, has high latency and causes additional costs.

For most of the messages, it might be enough for the user to have only 
the first part of the fraction.
For other messages, the user might want to read the complete text.


Details from the spec
---------------------

The required attribute "reception_status" in the MAP-msg-listing is set 
to "fractioned" for the specific message.
For normal messages it's set to "complete".

Two possibilities to download fractioned messages:
(1) Retreive complete message at once:
     One OBEX Get request (GetMessage omitting parameter FractionRequest)
     One OBEX Get response (bMessage)
     The MSE has to download the complete message from the internet and 
deliver it transparently to the client

(2) Retreive message in fractions:
     Several OBEX Get requests (GetMessage, set parameter 
FractionRequest to "first" or "more")
     Several OBEX Get responses (first: bMessage, further: bBody, 
parameter FractionDeliver is set to "more" or "last")
     The fractions of one message must be downloaded sequentially and it 
is not supported to interrupt by calling GetMessage for
     a different message


There are different ways how client applications might want to deal with 
such messages.
Simplest way is to always download the full message as described in (1). 
This is however not desirable for complex scenarios.

Applications would most likely want to achieve some kind of caching for 
messages providing fast access to them.
In this case the application would download only the first fraction for 
all messages it is interested in.
The missing parts of specific messages is downloaded only if the user 
wants to see the details.
One use case here is to download the rest of the message on the fly, as 
soon as the user starts scrolling further down in the UI.

Therefore I'm not convinced that adding a suspend state to the transfer 
would be a good idea.
A transfer encapsulates exactly one OBEX Get call (and the continuation 
if the payload does not fit into one packet).
The fractioned message download however consists of multiple OBEX Get calls.

For the caching solution, where you would download the first fraction of 
all messages, your approach would create
one suspended transfer object for all messages, each having opened a file.
Also we cannot easily continue a specific transfer, we would need to 
internally start at the beginning again.

I fear that this solution would lead into a waste of resources and also 
adds unnecessary complexity to the transfer object.
In addition, continuous writing to one file does not really simplify 
things as well.
The first fraction is already a valid bMessage object, further fractions 
contain enclosed bBody objects.
Since the application has to deal with the bMessage format already, 
there is no need to hide the fractions in the transfer objects.

The proposed way of simply adding a FractionDeliver parameter to the 
message meta data, allows the application to easily
deal with the fractions without adding too much complexity to itself or 
BlueZ.

Let me know if you need more details, I hope that answers some of the 
option questions.

Thanks and Br,
Christian
