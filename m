Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1436541112-21844-2-git-send-email-gowtham.ab@samsung.com>
References: <1436541112-21844-1-git-send-email-gowtham.ab@samsung.com>
	<1436541112-21844-2-git-send-email-gowtham.ab@samsung.com>
Date: Wed, 15 Jul 2015 14:43:42 +0300
Message-ID: <CABBYNZ+pEVWT=d==PYn1ovbjFjdY-b-WTcMYYwVM96ZQzKfmzw@mail.gmail.com>
Subject: Re: [RFC 1/3] doc/obex-agent-api: Add AuthorizeGet method
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Gowtham Anandha Babu <gowtham.ab@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Bharat Panda <bharat.panda@samsung.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gowtham,

On Fri, Jul 10, 2015 at 6:11 PM, Gowtham Anandha Babu
<gowtham.ab@samsung.com> wrote:
> This patch introduces the AuthorizeGet method to authorize
> incoming opp get request from opp clients.
> ---
>  doc/obex-agent-api.txt | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>
> diff --git a/doc/obex-agent-api.txt b/doc/obex-agent-api.txt
> index 3923da6..ee27ba6 100644
> --- a/doc/obex-agent-api.txt
> +++ b/doc/obex-agent-api.txt
> @@ -59,3 +59,33 @@ Methods              void Release()
>                         This method gets called to indicate that the agent
>                         request failed before a reply was returned. It cancels
>                         the previous request.
> +
> +Service                unique name
> +Interface      org.bluez.obex.Agent2
> +Object path    freely definable
> +
> +Methods                void Release()
> +
> +                       This method gets called when the service daemon
> +                       unregisters the agent. An agent can use it to do
> +                       cleanup tasks. There is no need to unregister the
> +                       agent, because when this method gets called it has
> +                       already been unregistered.
> +
> +               string AuthorizeGet()

It should be fd Authorize(string name, string mimetype), the returned
fd is then used in the following way:

- GET: read(fd,...)
- PUT: write(fd,...)

> +
> +                       This method gets called when the service daemon
> +                       needs to accept/reject a Bluetooth object get request.
> +                       It request user the complete path of the local file.
> +
> +                       Returns the full path (including the filename) where
> +                       the local file exists.
> +
> +                       Possible errors: org.bluez.obex.Error.Rejected
> +                                        org.bluez.obex.Error.Canceled
> +
> +               void Cancel()
> +
> +                       This method gets called to indicate that the agent
> +                       request failed before a reply was returned. It cancels
> +                       the previous request.
> --
> 1.9.1

I think you misunderstood the general idea, the point of having a
different interface is that it give us the ability to change how the
agent works, most likely we want to make use of fd passing and make
Authorize generic for both PUT and GET commands, the way you did it we
would need 2 agents one for PUT and another for GET, also we need a
new Register method so the agent is able to detect obexd support the
new type of agent and register it.

We also discussed with gnome folks the possibility of the agent
registering its FTP shared folder instead of having it as command line
parameter, this could also be done using file descriptor using O_PATH
along with openat/fdopendir but I guess we can discuss about this
later, the important part is that new Register have a dict so this
kind of options can be added if necessary. Also it might be convenient
to add RequestDefaultAgent like it was done for the pairing agent so
that means we can have multiple agent, one for each user, but once the
session is changed it can request to become the default.

-- 
Luiz Augusto von Dentz
