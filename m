Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZLJQgaCBF+Zame4fG_pN9Twu6_zaJb+42KmES8xvnZ1zg@mail.gmail.com>
References: <1320763033-4072-1-git-send-email-bulislaw@linux.com>
	<CABBYNZLJQgaCBF+Zame4fG_pN9Twu6_zaJb+42KmES8xvnZ1zg@mail.gmail.com>
Date: Mon, 14 Nov 2011 09:21:47 +0100
Message-ID: <CA+i+Aw3rTf3MxQUyeT9_FXZ6qU9mrDd4nppM4sP603Ah_4cxcw@mail.gmail.com>
Subject: Re: [RFC] API v2 for MAP client in obex-client
From: Slawomir Bochenski <lkslawek@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Bartosz Szatkowski <bulislaw@linux.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Nov 10, 2011 at 12:28 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Bartosz,
>
> On Tue, Nov 8, 2011 at 4:37 PM, Bartosz Szatkowski <bulislaw@linux.com> wrote:
>> Hi,
>> below tweaked proposal for MAP client API.
>>
>> Messages Access hierarchy
>> =========================
>>
>> Service         org.openobex.client
>> Interface       org.openobex.MessagesAccess
>> Object path     [variable prefix]/{session0,session1,...}
>>
>> Methods         dict(uint8 tag, variant value) GetAppParams()
>>
>>                        Retrieve application parameters connected to the last MSE
>>                        response. Application parameters corresponding to given call
>>                        are accessible until next request is sent.
>>
>>                        Parameters are converted to unsigned integers of corresponding sizes
>>                        (MAP specification section 6.3.1) or NULL-terminated strings.
>>                        In case of parameters not mentioned in MAP specification value
>>                        becomes struct of (uint8 length, array{uint8}).
>>
>>                        See MAP specification (section corresponding to given function)
>>                        for more details on returned parameters.
>
> Can't we have the tags as Properties, the direct mapping of the spec
> is bad because then each application needs to know about every tag,

Even though I'd rather go for tag names in strings instead of
numerical form, I do not see a problem with this. Application does not
need to know about each and every tag. It is enough to know the tags
that the application is interested in and skip the rest.

> besides I don't want to have each of the clients polling this values
> so there got to be a better way to deal with it.

Well, as those can also be received after finished GetMessage, which
seems to be asynchronous in this proposal, I guess this polling is
quite reasonable.

>>                void SetFolder(boolean cdup, string name)
>>
>>                        Set working directory for current session.
>>
>>                        |  cdup  | folder name | operation    |
>>                        |=====================================|
>>                        | FALSE  | empty       | cd /         |
>>                        |--------+-------------+--------------|
>>                        | FALSE  | name        | cd name      |
>>                        |--------+-------------+--------------|
>>                        | TRUE   | [name]      | cd ..[/name] |
>>                        +-------------------------------------+
>
> I thought we agree to have it just with name to make it less
> complicated and aligned with what we do for other profiles.

Not really complicated and allowing for full original functionality -
i.e. one can go backwards and to subdirectory in one request. This is
much easier than allowing for some "../subdir" as the only accepted
path form (as no any other paths would be appropriate). Also there are
no restrictions upon what characters could be used for folder name in
MAP server implementation (even "..").

>>                array{dict(string property, string value)}
>>                GetFolderListing(dict(uint8 tag, uint16 value))
>>
>>                        Retrieve list of names (and all other properties returned by MSE)
>>                        for directories in CWD.
>>
>>                        Parameters as in MAP specification section 5.4.
>
> IMO this is too low level and potentially creates a need of a
> header/library to export what values can tag and value can assume.
>
>>                array{dict(string property, string value)}
>>                GetMessageListing(string folder, array{uint8 tag, variant value})
>>
>>                        Return message listing for given subfolder of CWD or directly
>>                        CWD if folder field is empty, format of each dict entry
>>                        corresponds to the message listing format (MAP specification
>>                        section 3.1.6).
>>
>>                        Parameters as in MAP specification section 5.5.
>
> Same as GetFolderListing, also we should probably only list Message of
> the current folder otherwise we don't need ChangeFolder.

In every place in MAP specification "folder" is a name of subfolder,
no path is acceptable. This is the same here. This parameter is
guaranteed by MAP specification, so you can list messages one level
below your cwd (which is convenient). Same feature is also present in
folder listing in OBEX specification in general, however MAP
specification does not mandate name parameter for giving child dir in
GetFolderListing - probably someone forgot about it...

>>                object_path
>>                GetMessage(string handle, dict(uint8 tag, variant value), string filename)
>>
>>                        Retrieve message (in BMSG format) from remote device and save
>>                        it to a file *filename* (filename should be an absolute path
>>                        and the file would be overwritten if it already exists).
>>
>>                        A new Transfer object is created to represent this transaction
>>                        and object_path pointing to it is returned.
>>
>>                        Parameters as in MAP specification section 5.6.
>
> Where this handle comes from? Also Im not sure what the second
> parameter is for apparently it is use as a filter in other Methods but
> here you want to read one single message so what this filter is for?

Handle is one of key terms in MAP. Those are unique in whole tree
representation (i.e. getting message is independent from cwd). Those
are retrieved in messages listing. For me (as I actually know MAP)
also second parameter looks obvious - it's for setting optional
parameters in request, and GetMessage can take those.

>>
>>                void SetMessageStatus(string handle, uint8 indicator, uint8 value)
>>
>>                        Modify status of a message on remote device.
>>
>>                        Parameters as in MAP specification section 5.7.
>
> What application will be using this? Can any application update the
> status of a message?

Yes it can. This is used for setting read status and (un)deleting messages.

> Again by using a binary format defined in the
> spec it gonna create either duplicated code to define them in each
> client or a need for a header/library.
>
>>                void UpdateInbox()
>>
>>                        Initiate update of inbox status on remote device.
>
> Again what application want to use this? This looks like a
> notification from the server, which should be done by obexd not
> obex-client.

>From MAP specification:

<quote>
5.9 UpdateInbox function
This function allows the MCE to initiate an update of the MSE's inbox,
i.e. the MSE shall
contact the network (e.g. its mailbox) to retrieve new messages if available.
</quote>

MCE is obex-client.

-- 
Slawomir Bochenski
