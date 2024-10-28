Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E2A12F585
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Oct 2024 15:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730129741; cv=none; b=e4oK3qQFkUttd/H6IAqZKZa91ZiM/gHqhB4u2ehoqaWbQYW9qC+YikbWm4AaW1JI9CKRqWoccAQiV+iSfX7km4NsDeC12KjK/WXadoBHP8pPbOiHkMISeKZCQew6iSZtXhTGT72eqd8NdYP+AXCb2pltHpwrjpdkUqimC0WIf4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730129741; c=relaxed/simple;
	bh=yNNGiPThcprUIftKV1IrCtUCLrzyi91CA6uMShBo9Qg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZTLZ52c3OItldbz+xV09l2xV3tSLqxNydQUWgDfTfeHWv2gvE0cyLeRMK+kWOkPYluq/M9m0rMiuOQolOcxuAFcOLX+9hEMK47FFSdvhCBnB36MPNhci/AMPXUFVMRoSLjTAWPbIpuOQuFJNQyNo/P+nDBdaVhsPuFNNB+5/ITM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6FD98E0002;
	Mon, 28 Oct 2024 15:35:36 +0000 (UTC)
Message-ID: <2d19a91da040a9298402303377ddc8c02a6a2c9a.camel@hadess.net>
Subject: Re: [BlueZ v3 7/7] client: Fix --help hanging if bluetoothd is not
 running
From: Bastien Nocera <hadess@hadess.net>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Mon, 28 Oct 2024 16:35:36 +0100
In-Reply-To: <CABBYNZ+aMaDp0BC6F0yG+mJU9hgkeNtbOxNwYx1D7Yj3rU8bzw@mail.gmail.com>
References: <20241022141118.150143-1-hadess@hadess.net>
	 <20241022141118.150143-8-hadess@hadess.net>
	 <CABBYNZ+aMaDp0BC6F0yG+mJU9hgkeNtbOxNwYx1D7Yj3rU8bzw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-GND-Sasl: hadess@hadess.net

On Thu, 2024-10-24 at 12:08 -0400, Luiz Augusto von Dentz wrote:
> Hi Bastien,
>=20
> On Tue, Oct 22, 2024 at 10:11=E2=80=AFAM Bastien Nocera <hadess@hadess.ne=
t>
> wrote:
> >=20
> > Exit after printing all the main and submenu commands.
> > ---
> > =C2=A0client/main.c | 2 ++
> > =C2=A01 file changed, 2 insertions(+)
> >=20
> > diff --git a/client/main.c b/client/main.c
> > index f60bef1a6d3a..f5ed9f9f5297 100644
> > --- a/client/main.c
> > +++ b/client/main.c
> > @@ -3193,6 +3193,8 @@ int main(int argc, char *argv[])
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 assistant_add_submenu();
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bt_shell_set_prompt(PROMPT_O=
FF, NULL);
> >=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bt_shell_handle_non_interactive_h=
elp();
> > +
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (agent_option)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 auto_register_agent =3D g_strdup(agent_option);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else
> > --
> > 2.47.0
> >=20
>=20
> Having some thoughts about how to do this is more clean way, perhaps
> we should do this as part of bt_shell_run and then introduce .run
> callback to bt_shell_menu so it is called as part of bt_shell_run,
> under the .run callback the menu can place e.g. DBUS connection
> setup,
> etc, but before it reaches that we can check if it just a help
> pending.

We need to:
1) set the top menu
2) populate the submenus without any D-Bus IO
3) turn off the prompt
4) print the help and exit if that's what was requested
5) setup IO for submenus
6) run the mainloop

I guess I could do 2) with a callback from bt_shell_set_menu()
and then do 4) and 5) from a bt_shell_run() callback.

Is that what you expected?
Do you have preferred names for the callback functions?

I think that we can still use the function split from 3/7, did you have
a better name for the functions?

Cheers

