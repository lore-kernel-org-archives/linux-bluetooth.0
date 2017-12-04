Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Mon, 4 Dec 2017 14:36:06 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Steve Brown <sbrown@cortland.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: meshctl: Can't connect via Node Identity advertisement
Message-ID: <20171204123606.GA29257@x1c.lan>
References: <1512344374.16639.18.camel@ewol.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1512344374.16639.18.camel@ewol.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Steve,

On Sun, Dec 03, 2017, Steve Brown wrote:
> Connect via Net ID works without a problem.
> 
> I'm using meshctl with zephyr's mesh_shell (upstream version)
> 
> I provision the shell and turn on it's gatt-proxy. Then I exit meshctl,
> run it again and issue a "connect 0". It reconnects to the mesh without
>  a problem.
> 
> If I turn off the shell's gatt-proxy, start meshctl, issue a 
> "connect 0" and then issue a shell "ident". I get no connection. The
> ident command only transmits advertisements for a short period of time.
> 
> The CONN_TYPE_IDENTITY path in parse_mesh_service_data() seems broken.
> The comparison of data[0] and connection.type fails. The value of
> data[0] is 1 (CONN_TYPE_IDENTITY) and the value of connection.type is
> 0.

Looking at mesh/main.c it seems to me like the connect command is
currently only desgined for connecting to Network Identity
advertisements (which is also implied by the fact that it takes a NetKey
Index as an optional parameter value).

What would be needed is some command which takes an element address
rather than a NetKey Index as input. Just thinking out loud, but maybe
"connect" should be renamed to "connect-net" and then a new
"connect-node" command could be introduced that would look for Node
Identity advertisements?

Johan
