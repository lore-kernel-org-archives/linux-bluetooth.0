Return-Path: <cyrus@holtmann.org>
Message-ID: <ac8af0be0810200221wff8bb75gf8d69b523ee3ea3b@mail.gmail.com>
Date: Mon, 20 Oct 2008 17:21:05 +0800
From: "Zhao Forrest" <forrest.zhao@gmail.com>
To: "Marcel Holtmann" <marcel@holtmann.org>
Subject: Re: PBAP storage plugin API proposal
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <1224304182.9386.14.camel@californication>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <ac8af0be0810080159h712b0f8drdffa49dc57d7afb5@mail.gmail.com>
	 <1223457456.11272.254.camel@violet.holtmann.net>
	 <ac8af0be0810081843i8bd6bd3g7282b11e3e9c8b1e@mail.gmail.com>
	 <1224304182.9386.14.camel@californication>
List-ID: <linux-bluetooth.vger.kernel.org>

>> Yes. My proposed PBAP storage API follows this rule, but lacks the
>> method to unregister the operations. Will add it later.
>
> I put some prototype declarations into the obexd repository. The
> important part is that we have to do this in an async way. We can't
> block while retrieving the phonebook information.
>

I'm implementing PBAP driver framework and a simple(or prototype) PBAP
driver based on your prototype declarations. Will add some extentions
to the prototype declarations if necessary.
To do that in an async way I think the basic idea is:
1 when PBAP driver is loaded(or initialized), fork() is invoked to run
PBAP driver in child process
2 the Unix domain socket is used to communicate between PBAP server
and PBAP driver; and PBAP server acts as client role at the one end of
socket, PBAP driver acts as server role at the other end of socket
3 everytime a PBAP client connects to PBAP server(i.e. a OBEX session
is initiated), PBAP server initiates a session(or a socket) with PBAP
driver by invoking connect(). Then PBAP server sends subsequent PBAP
request(pullphonebook, pullvcardlisting, pullvcardentry) through this
socket; PBAP driver sends back the requested data through the socket
asyncronously.
Am I right? I'd like to first make the basic design ideas clear in
order to avoid the unnecessary misunderstanding or confusion before
starting to write the code.

Thanks,
Forrest
