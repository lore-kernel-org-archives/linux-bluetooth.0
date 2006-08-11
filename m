Return-Path: <ulissesf@gmail.com>
Message-ID: <d23110170608111309q263bc87fyf6474dce4d0e535e@mail.gmail.com>
Date: Fri, 11 Aug 2006 17:09:40 -0300
From: "Ulisses Furquim" <ulissesf@gmail.com>
To: "Marcel Holtmann" <marcel@holtmann.org>
Subject: Re: [Bluez-devel] "File descriptor in bad state" on sdp_connect()
Cc: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1155333717.4518.14.camel@aeonflux.holtmann.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <44D88EC1.7010009@pracucci.com> <44D8815D.4000108@infitsrl.com>
	 <d23110170608090806j2b39e87eqd84ba9843d216153@mail.gmail.com>
	 <1155236923.4492.49.camel@aeonflux.holtmann.net>
	 <d23110170608111203g590369d4qdc4592c284eafa55@mail.gmail.com>
	 <1155333717.4518.14.camel@aeonflux.holtmann.net>
List-ID: <bluez-devel.lists.sourceforge.net>

On 8/11/06, Marcel Holtmann <marcel@holtmann.org> wrote:
> look into l2cap_conn_del() and check what happens if l2cap_data is NULL.
> This doesn't change the behavior.

Doooh. Right. We shouldn't be calling l2cap_conn_del() at all if
l2cap_data is NULL so it doesn't change any behavior and we actually
save one function call. :-)

Regards,

-- Ulisses
