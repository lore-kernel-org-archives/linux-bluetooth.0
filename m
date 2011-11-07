Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAPGrrxWa_sCC8OpCGhsc_aJfeRYm=hCrghUCLb+rian9SFrN4Q@mail.gmail.com>
References: <CAPGrrxXkvaNjnUT9vJ8sdnHuabF7zwtWnOnnbLD1+G0huvj1xw@mail.gmail.com>
	<ca9f11c3ddb562558c25a7ff185407ad@mail.hendrik-sattler.de>
	<CAPGrrxWm=gfcdr6bCVneQFJiGsrajKqojZ-iES28=isitC1jiw@mail.gmail.com>
	<CABBYNZ+bqrdJwvOH3Uznbc54TaF=4c=VFBZ4ZG9_9aYOc2e=9w@mail.gmail.com>
	<CAPGrrxWW4FM2ZkQP+toSeRPMYMQpSiRW5p8N9+8EM1LU3PvwdQ@mail.gmail.com>
	<CABBYNZLmfwA9ivmnTvSTsCsvZV9aejqRov7gX1hwnXWreExg5w@mail.gmail.com>
	<CAPGrrxVpG_33A9T5XynmUBHcS4Wi7CrHE8Lgi5HJcdR31jM0mw@mail.gmail.com>
	<CABBYNZLtfPpdj_-qDp4zXjq5EPt4aOG8_RqSHe3PtOSdt7QVZQ@mail.gmail.com>
	<CAPGrrxWJWc4NxKswgB2yu6UvfiUe-j+6r5M_wtpSh3TGs3QL8w@mail.gmail.com>
	<CABBYNZJ7P2NAKD27D7sqHxP4QshiUx8ne=L57rugDoP__sHsyw@mail.gmail.com>
	<CAPGrrxWa_sCC8OpCGhsc_aJfeRYm=hCrghUCLb+rian9SFrN4Q@mail.gmail.com>
Date: Mon, 7 Nov 2011 15:20:21 +0200
Message-ID: <CABBYNZKW_fu1cqzV336PxqU3Vvb1Ht9cdX6S_OTob+a=1WSiaw@mail.gmail.com>
Subject: Re: [RFC] API for MAP client in obex-client
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Bartosz Szatkowski <bulislaw@linux.com>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bartosz,

On Mon, Nov 7, 2011 at 2:42 PM, Bartosz Szatkowski <bulislaw@linux.com> wrote:
> On Mon, Nov 7, 2011 at 11:37 AM, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
>> Hi Bartosz,
>>
>> On Mon, Nov 7, 2011 at 11:46 AM, Bartosz Szatkowski <bulislaw@linux.com> wrote:
>>> On Fri, Nov 4, 2011 at 1:00 PM, Luiz Augusto von Dentz
>>> <luiz.dentz@gmail.com> wrote:
>>>> Hi Bartosz,
>>>>
>>>> On Thu, Nov 3, 2011 at 9:01 PM, Bartosz Szatkowski <bulislaw@linux.com> wrote:
>>>>>
>>>>> Generally you may be right, but i'm not sure whether actually tangling
>>>>> agent (client of the client?) is a good idea -- I'll check it
>>>>> tomorrow, but AFAIR it's  an additional reversed connection? And
>>>>> situation with this big message probably is not so often to cause such
>>>>> a confusion. I would really like to use such API in simplest possible
>>>>> way, by calling some method and receiving answer and its exactly what
>>>>> is accomplished with fd.
>>>>
>>>> I haven't seen the implementation but I have a feeling it won't be
>>>> that simple, if you use the pipe/unix socket to stream the data them
>>>> you end up copying data and the stream still need to be handled  in
>>>> client side which will very likely copy/convert the data again. We
>>>> have tried such a thing before with A2DP and it was consider
>>>> inefficient, so what we do nowadays is passing the bluetooth socket
>>>> itself to PulseAudio but note that here it would not be a good idea
>>>> since the client would have to deal with OBEX protocol directly.
>>>>
>>>> You could return the transfer object on GetMessage, actually is is
>>>> probably a good idea to do this also for GetFile/PutFile, so that the
>>>> caller application have direct control on the transfers it has started
>>>> and we can probable have a property e.g. Status (Transferring, Error,
>>>> Complete) to indicate the transfer status, that would remove the need
>>>> to have an agent in the application although the system may still have
>>>> one to track the progress and keep history of the transfers.
>>>>
>>>> --
>>>> Luiz Augusto von Dentz
>>>>
>>>
>>> As far as i can tell adding transfer would be good idea and it's not
>>> necessary to actually track it. But there is still question how to
>>> transfer data? I'm still convinced that passing fd is good idea, maybe
>>> even more flexible would be to pass it from user to obex-client in
>>> DBus call, so user may decide whether it would be more convenience to
>>> use file, pipe or whatever.
>>>
>>> So method may look something like this:
>>>
>>> string GetMessage(unix_fd msgfd, string handle, dict(uint8 tag, variant value))
>>>
>>> Returning path to the newly created transfer.
>>
>> As I told you passing a fd to pass data is not very efficient because
>> you are just adding an intermediate buffer since obexd will have to
>> copy from the socket to the fd where the client read (btw buffering
>> the whole message in the client is probably a bad idea), in the other
>> hand the fd could be of a file that would probably work better but it
>> is no much different than passing a path which was my initial
>> suggestion and is probably simpler to implement because we have been
>> doing this already. This way when the transfer is completed it just a
>> matter of reading the file.
>>
>> --
>> Luiz Augusto von Dentz
>>
>
> Generally GetMessage (x-bt/message) is set to be buffered in
> obc_transfer_get - so there is (AFAICT) no real difference what we
> would do with this buffer. And if we would like to modify it to use
> file buffering, we can use usr provided fd rather then file name and
> let client decide where to store it. In sake of user app simplicity,
> as you say earlier.

That is nothing that couldn't be changed, also whether it is a path or
not the user is still deciding where it should be stored but I guess a
path is actually less troublesome to the client to deal with since not
every binding supports fd passing which can be a problem to end user
application which I suppose this API should be targeting, also using
paths is consistent with other parts of the code GetFile/PutFile.

-- 
Luiz Augusto von Dentz
