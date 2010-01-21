Return-Path: <cyrus@holtmann.org>
Date: Thu, 21 Jan 2010 21:22:09 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>, ofono@ofono.org,
	zhenhua.zhang@intel.com
Subject: Re: [RFC] HFP support into oFono and BlueZ
Message-ID: <20100121192209.GA30879@jh-x301>
References: <fbf08281001110908s2c3412m456b3aa980b8ca10@mail.gmail.com>
 <fbf08281001111105pc2f0d3au61d0e205e1689ec2@mail.gmail.com>
 <fbf08281001131539l342a3062w70883c197dc52983@mail.gmail.com>
 <fbf08281001201158q23d13d9bj930a66271c527b43@mail.gmail.com>
MIME-Version: 1.0
Content-Type: application/octet-stream;
	name="0002-Implement-HandsfreeGateway-Interface.patch"
In-Reply-To: <fbf08281001201158q23d13d9bj930a66271c527b43@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,=0A=0ASorry about the delay in getting more comments from me. He=
re's the=0Aresult of an initial (and rather quick) review:=0A=0A+static con=
st char *connected2str(int i)=0A+{=0A+	switch (i) {=0A+		case GATEWAY_STATE=
_DISCONNECTED:=0A+			return "disconnected";=0A+		case GATEWAY_STATE_CONNECT=
ING:=0A+			return "connecting";=0A+		case GATEWAY_STATE_CONNECTED:=0A+			re=
turn "connected";=0A+		case GATEWAY_STATE_PLAYING:=0A+			return "playing";=
=0A+		default:=0A+			return "";=0A+	}=0A+}=0A=0AThis should be called state=
2str and the state is gateway_state_t and not=0Aint. Also name the variable=
 more apropriately (e.g. "state").=0A=0A+static void change_state(struct au=
dio_device *dev, int new_state)=0A=0ASame goes here. gateway_state_t and no=
t int.=0A=0A+	gw->sco =3D chan;=0A+	g_io_channel_ref(chan);=0A=0AThe conven=
tion is to do the variable assignment through the return value=0Aof the _re=
f function. Please do that.=0A=0A-	/* why is this here? */=0A 	fcntl(g_io_c=
hannel_unix_get_fd(chan), F_SETFL, 0);=0A=0AWhy are you removing this comme=
nt? Either remove the fcntl call=0Aaltogether, fix the comment to describe =
why the call is needed or then=0Adon't do anything if you don't know what i=
t's for.=0A=0A+	if (!dbus_set_error_from_message(&derr, reply)) {=0A+		info=
("Agent reply: file descriptor passed successfuly");=0A+		return;=0A+	}=0A=
=0AI don't think this is worth an info(). Use debug() instead.=0A=0A+	g_idl=
e_add(gateway_close, gw);=0A=0ADo you really need to call gateway_close thr=
ough an idle callback?=0AWhat's the problem with calling it directly?=0A=0A=
+	/* make /dev/rfcomm serial port from chan */=0A+	memset(&req, 0, sizeof(r=
eq));=0A+	req.dev_id =3D -1;=0A+	req.flags =3D (1 << RFCOMM_REUSE_DLC);=0A+=
	bacpy(&req.src, &dev->src);=0A+	bacpy(&req.dst, &dev->dst);=0A+	req.channe=
l =3D gw->channel;=0A=0AWhat's this? I thought you removed all the RFCOMM T=
TY codde.=0A=0A+	return;=0A }=0A=0AUnnecessary return at the end of a void =
function.=0A=0A+	agent =3D g_new0(struct agent, 1);=0A+	if (!agent)=0A+		re=
turn g_dbus_create_error(msg,=0A+				ERROR_INTERFACE ".Failed",=0A+				"Fai=
led to create a new agent");=0A=0Ag_new0() will either assert or always ret=
urn non-NULL. Use g_try_new0=0Aif you want to check for failure, but probab=
ly you can just remove the=0Acheck and keep using g_new0. Btw, src/agent.h =
already defines a struct=0Aagent so it'd be better if you use another name,=
 e.g. hf_agent.=0A=0A=0A+	agent->name =3D strdup(name);=0A+	agent->path =3D=
 strdup(path);=0A=0AUse g_strdup.=0A=0A+	g_io_channel_ref(chan);=0A+	dev->g=
ateway->rfcomm =3D chan;=0A=0AAgain, please do the assignment through the r=
eturn value of _ref()=0A=0AThere are probably more issues, but these are th=
e ones I found after an=0Ainitial glance-through. Please send an updated pa=
tch, preferably inline=0A(since as you notice I didn't manage to get my mai=
ler to properly quote=0Athis time) and I'll take a new look. Thanks.=0A=0AJ=
ohan=0A
