Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <912bb79a0911292226o1c42baeemb2a8596fce465e65@mail.gmail.com>
References: <912bb79a0911292226o1c42baeemb2a8596fce465e65@mail.gmail.com>
Date: Mon, 30 Nov 2009 12:48:01 -0200
Message-ID: <f9d4bd30911300648v4fc8d1f2pfa59fae4e7548107@mail.gmail.com>
Subject: Re: Problem in understanding of agent
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: nirav rabara <niravrabara@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Nov 30, 2009 at 4:26 AM, nirav rabara <niravrabara@gmail.com> wrote:
> Hi,
>
> I am newbie to bluetooth, I have gone through agent.c and simple-agent
> but not getting clear idea, how agent works??
> Because In my application i m using Qt , I am poor at GTK+ , glib and pthython.
> But what I understood is Agent will contain all the function defined
> in agent.api, and when PIN requrest comes this api will serve the
> request for this we need to create agent and register agent.
>
> I am using qt binding, can anybody show me the right direction to
> implement agent??
>
> Your suggestion would be a great help for me
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

Hi Nirav,

You can find an example of obex-client agent here:
http://gitorious.org/qt-obex-ftp-client-library

The concept is similar, copy the agent/adaptor code and implement the
methods based on the API description only.
Let me know if you still have problem. We can publish an example of a Qt agent.

Br,
Claudio.
-- 
--
Claudio Takahasi
Instituto Nokia de Tecnologia
Recife - Pernambuco - Brasil
+55 81 30879999
