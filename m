Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Steve Brown <sbrown@cortland.com>
Message-ID: <1512392802.27418.8.camel@ewol.com>
Subject: Re: meshctl: Can't connect via Node Identity advertisement
To: Johan Hedberg <johan.hedberg@gmail.com>,
        Steve Brown <sbrown@cortland.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Mon, 04 Dec 2017 06:06:42 -0700
In-Reply-To: <20171204123606.GA29257@x1c.lan>
References: <1512344374.16639.18.camel@ewol.com>
         <20171204123606.GA29257@x1c.lan>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Mon, 2017-12-04 at 14:36 +0200, Johan Hedberg wrote:
> Hi Steve,
> 
> On Sun, Dec 03, 2017, Steve Brown wrote:
> > Connect via Net ID works without a problem.
> > 
> > I'm using meshctl with zephyr's mesh_shell (upstream version)
> > 
> > I provision the shell and turn on it's gatt-proxy. Then I exit
> > meshctl,
> > run it again and issue a "connect 0". It reconnects to the mesh
> > without
> >  a problem.
> > 
> > If I turn off the shell's gatt-proxy, start meshctl, issue a 
> > "connect 0" and then issue a shell "ident". I get no connection.
> > The
> > ident command only transmits advertisements for a short period of
> > time.
> > 
> > The CONN_TYPE_IDENTITY path in parse_mesh_service_data() seems
> > broken.
> > The comparison of data[0] and connection.type fails. The value of
> > data[0] is 1 (CONN_TYPE_IDENTITY) and the value of connection.type
> > is
> > 0.
> 
> Looking at mesh/main.c it seems to me like the connect command is
> currently only desgined for connecting to Network Identity
> advertisements (which is also implied by the fact that it takes a
> NetKey
> Index as an optional parameter value).
> 
> What would be needed is some command which takes an element address
> rather than a NetKey Index as input. Just thinking out loud, but
> maybe
> "connect" should be renamed to "connect-net" and then a new
> "connect-node" command could be introduced that would look for Node
> Identity advertisements?
> 
> Johan

It's obvious after you pointed it out. I hadn't appreciated the
distinction between the two types of advertisements. I'll try to do
what you suggest.

Steve



