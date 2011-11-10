Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1320763033-4072-1-git-send-email-bulislaw@linux.com>
References: <1320763033-4072-1-git-send-email-bulislaw@linux.com>
Date: Thu, 10 Nov 2011 13:28:25 +0200
Message-ID: <CABBYNZLJQgaCBF+Zame4fG_pN9Twu6_zaJb+42KmES8xvnZ1zg@mail.gmail.com>
Subject: Re: [RFC] API v2 for MAP client in obex-client
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Bartosz Szatkowski <bulislaw@linux.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bartosz,

On Tue, Nov 8, 2011 at 4:37 PM, Bartosz Szatkowski <bulislaw@linux.com> wrote:
> Hi,
> below tweaked proposal for MAP client API.
>
> Messages Access hierarchy
> =========================
>
> Service         org.openobex.client
> Interface       org.openobex.MessagesAccess
> Object path     [variable prefix]/{session0,session1,...}
>
> Methods         dict(uint8 tag, variant value) GetAppParams()
>
>                        Retrieve application parameters connected to the last MSE
>                        response. Application parameters corresponding to given call
>                        are accessible until next request is sent.
>
>                        Parameters are converted to unsigned integers of corresponding sizes
>                        (MAP specification section 6.3.1) or NULL-terminated strings.
>                        In case of parameters not mentioned in MAP specification value
>                        becomes struct of (uint8 length, array{uint8}).
>
>                        See MAP specification (section corresponding to given function)
>                        for more details on returned parameters.

Can't we have the tags as Properties, the direct mapping of the spec
is bad because then each application needs to know about every tag,
besides I don't want to have each of the clients polling this values
so there got to be a better way to deal with it.

>                void SetFolder(boolean cdup, string name)
>
>                        Set working directory for current session.
>
>                        |  cdup  | folder name | operation    |
>                        |=====================================|
>                        | FALSE  | empty       | cd /         |
>                        |--------+-------------+--------------|
>                        | FALSE  | name        | cd name      |
>                        |--------+-------------+--------------|
>                        | TRUE   | [name]      | cd ..[/name] |
>                        +-------------------------------------+

I thought we agree to have it just with name to make it less
complicated and aligned with what we do for other profiles.

>                array{dict(string property, string value)}
>                GetFolderListing(dict(uint8 tag, uint16 value))
>
>                        Retrieve list of names (and all other properties returned by MSE)
>                        for directories in CWD.
>
>                        Parameters as in MAP specification section 5.4.

IMO this is too low level and potentially creates a need of a
header/library to export what values can tag and value can assume.

>                array{dict(string property, string value)}
>                GetMessageListing(string folder, array{uint8 tag, variant value})
>
>                        Return message listing for given subfolder of CWD or directly
>                        CWD if folder field is empty, format of each dict entry
>                        corresponds to the message listing format (MAP specification
>                        section 3.1.6).
>
>                        Parameters as in MAP specification section 5.5.

Same as GetFolderListing, also we should probably only list Message of
the current folder otherwise we don't need ChangeFolder.

>                object_path
>                GetMessage(string handle, dict(uint8 tag, variant value), string filename)
>
>                        Retrieve message (in BMSG format) from remote device and save
>                        it to a file *filename* (filename should be an absolute path
>                        and the file would be overwritten if it already exists).
>
>                        A new Transfer object is created to represent this transaction
>                        and object_path pointing to it is returned.
>
>                        Parameters as in MAP specification section 5.6.

Where this handle comes from? Also Im not sure what the second
parameter is for apparently it is use as a filter in other Methods but
here you want to read one single message so what this filter is for?

>
>                void SetMessageStatus(string handle, uint8 indicator, uint8 value)
>
>                        Modify status of a message on remote device.
>
>                        Parameters as in MAP specification section 5.7.

What application will be using this? Can any application update the
status of a message? Again by using a binary format defined in the
spec it gonna create either duplicated code to define them in each
client or a need for a header/library.

>                void UpdateInbox()
>
>                        Initiate update of inbox status on remote device.

Again what application want to use this? This looks like a
notification from the server, which should be done by obexd not
obex-client.

-- 
Luiz Augusto von Dentz
