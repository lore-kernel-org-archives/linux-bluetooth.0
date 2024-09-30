Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B84619DF62
	for <linux-bluetooth@vger.kernel.org>; Mon, 30 Sep 2024 19:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727726236; cv=none; b=Y/ZgsT1oZfzKPn9+ZFGLlAO18PPe3UvPFR4CFI13qQY+ldeiE8ddynLtxM8vomYhNQYiHl2+Ppb3KQHz9iCqZIMkN0n69mnHz4cpYLfAe7NiDtf4mRN/KXiQoqz09uC1WFUlbz8eQJkordz17VnBkW7t1O6dCWUbsTgFfI9oCG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727726236; c=relaxed/simple;
	bh=ykNFm4fSUijEOnfe72oTOzt+Nqqt/uO1u2coqDr6owE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CPMF22lQnGwxZEwM/TC3ZCm1FaLBTr9fXtOiQn2gfygcZtrx0EXapx2XAbruPvJF7U+QYUHKIrVdL+l0cyhvwHtsK+PFT6e80VvEqRg3A0fMCeCU9bG/SiIz4loKGxuk5xLtna9pkz71b2ZHPEUCuejyDPcQka7NFh4l3Krsngk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FB2HTZ/C; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FB2HTZ/C"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2f75aaaade6so47827661fa.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Sep 2024 12:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727726232; x=1728331032; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/mru9BioSI2RwRUZ7/lslr8BV4mw4i1uorHKBo/sCDM=;
        b=FB2HTZ/CwVlUxjvX2kI9ceqJHEFKWyL8xHuH7M5+fwtNMR3AfnaTnP3AKIxyzPywgj
         98ibbOlcmvlpOnztteG8UCxl+vpmwH1Vy65q4yhqfXYz7rBP5jWici8HUGFNgVjPsi9q
         IBKCtYY+W72fOzhTI/yQ+FGuTcS/fswVg2XOcGhSIzUSM4pVVNEUcT1mNByDk2S6VIog
         8xlsHEKXN80giwHc3A97kVVw43tWX9Fi3ogkzNTGA7YDvMy+zs4QHTzP6Dm7GGf9+ced
         CLGnvcjEkwQNNYk72MkLvbAERNTxgChfn7yz02+erjG/NJWwRxWPoF+LkjPcLDmornZO
         pkkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727726232; x=1728331032;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/mru9BioSI2RwRUZ7/lslr8BV4mw4i1uorHKBo/sCDM=;
        b=qB9YR6ui21qCKhOdKx8Nj80NhI+ZD6WPxePrHLhO31Q7IhSziLWp4gxQCCyt3+IDEJ
         qzyQw9uA801r8u05Owf6MLhsYNMph6FrB8cYAI0ve0cz90oKCosaUwXsSU5gmr/MfYWp
         CAO15DkNGUrP92M3/GsIbGSBca/MvzIlpMqwOUKSmgmsorTbTXm7IV+EhZjMC2xqO2dG
         IfzC33mcGy2U5aUUfvIcUMTfUZt8CV2u9fAbhFYQY8BoERZ2+yE8qBaytIz1ZNO8Gy9H
         pGYk4MrLAPTtcgd/Z6n3I88f5eTeLiLiRXsUC606UpI29pAabhLR8rXKXBe0pSELw0Nt
         1Z7Q==
X-Gm-Message-State: AOJu0Yy8p7WEQ5gtItQQUMfedZff9PV4+PINFHMFqyC4f0b6gfGK4Ppe
	RV+uSUijq6gYdnV3rKlg/QIv7PHpXtXSMaih8yiMYGTJDogZBMQYy7EfN7zkhKnlI8T3xFBTRMB
	gBdSZM1mXkopvcrNk3IM8UOoiHNgHzQ==
X-Google-Smtp-Source: AGHT+IGjckikERs7VVAIHFWnlcVJzon2X5DIBkHfT/VxnjdYgamCPXRpCaJEZG3kbAMmQBzFizUaWJgd1DRFtehCoaA=
X-Received: by 2002:a2e:a593:0:b0:2f7:7d69:cb5d with SMTP id
 38308e7fff4ca-2f9d3db994dmr67679411fa.0.1727726231219; Mon, 30 Sep 2024
 12:57:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240927131441.2617450-1-quic_chejiang@quicinc.com>
 <CABBYNZJVVTqw=rz3ndWvak6=9PaQe0H1uwzT5qT+BK5D0R+_yg@mail.gmail.com> <fdaf49e9-5a93-42cc-8ae5-9691f4293145@quicinc.com>
In-Reply-To: <fdaf49e9-5a93-42cc-8ae5-9691f4293145@quicinc.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 30 Sep 2024 15:56:58 -0400
Message-ID: <CABBYNZKDzgb0MKu64b8VphVMP4xuHc4iSa_D5m5DaVjt73PQcA@mail.gmail.com>
Subject: Re: [PATCH v1] Client: Fix the list_attributes command returning
 nothing for a dual-mode remote
To: Cheng Jiang <quic_chejiang@quicinc.com>
Cc: linux-bluetooth@vger.kernel.org, quic_jiaymao@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Cheng,

On Sat, Sep 28, 2024 at 10:51=E2=80=AFPM Cheng Jiang <quic_chejiang@quicinc=
.com> wrote:
>
> Hi Luiz,
>
>
> On 9/27/2024 10:31 PM, Luiz Augusto von Dentz wrote:
> > Hi Cheng,
> >
> > On Fri, Sep 27, 2024 at 9:16=E2=80=AFAM Cheng Jiang <quic_chejiang@quic=
inc.com> wrote:
> >>
> >> When a dual-mode device is paired first on BR/EDR and
> >> then on BLE through RPA, the RPA changes to a public
> >> address after receiving the IRK. This results in two proxies
> >> in default_ctrl->devices with the same public address.
> >> In cmd_list_attributes, if the BR/EDR proxy is found first,
> >> it prints no attributes.
> >
> > This seems to be a bug then, if we resolve the address and there is
> > already a device object for it then that shall be used instead of
> > keeping 2 different objects paths, fixing bluetoothctl to allow
> > multiple proxies with the same device won't do anything for other
> > clients so this is just a workaround.
> >
> > There seems to be some code for detecting and merging the objects:
> >
> > /* It is possible that we have two device objects for the same device i=
n
> >  * case it has first been discovered over BR/EDR and has a private
> >  * address when discovered over LE for the first time. In such a case w=
e
> >  * need to inherit critical values from the duplicate so that we don't
> >  * ovewrite them when writing to storage. The next time bluetoothd
> >  * starts the device will show up as a single instance.
> >  */
> > void device_merge_duplicate(struct btd_device *dev, struct btd_device *=
dup)
> >
> > But it doesn't seem to carry over the services, etc, as it seems we
> > can't really just use one object at this point then both need to
> > interact with each other, perhaps by storing the duplicate into
> > btd_device so the right object can be used depending on the bearer,
> > etc.
> >
> Yes, this is just a workaround for the bluetoothctl client. The device_me=
rge_duplicate
> can't handle it. Actually, there are two different dbus interfaces create=
d for the
> two device objects. I didn't find a good way to merge these two dbus inte=
rface (I'm
> not familiar with dbus).
>
> Another thought is use the AddressType property to distinguish the two de=
vice objects.
> however, in current implementation, BR/EDR and BLE public address are bot=
h assumed as
> "public". Can we add a new string type (like "le_public") in `property_ge=
t_address_type`
> for BLE public address.
>
> Do you have any idea to get the bearer info in client?

Well one think that we should probably do is to list the GATT objects
on the public address, probe the services, etc, so they would appear
as duplicates but we can't really remove the object with the RPA
address while still connected as that will probably confuse the
clients, that said perhaps we should cleanup it when we disconnect
since at that point it is not longer needed and shall be consider
temporary.

As to how the client should handle this, I think the best way to
handle it to only show non-duplicate addresses, so in part I think we
need to change this in bluetoothctl and then document this behavior by
saying that there could be 2 different objects with the same Address
where the objects with the RPA address is to be considered temporary.

>
>
> >> Modify cmd_list_attributes to search all proxies in
> >> default_ctrl->devices and display the related attributes.
> >> ---
> >>  client/main.c | 55 +++++++++++++++++++++++++++++++++++++++++++++++---=
-
> >>  1 file changed, 51 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/client/main.c b/client/main.c
> >> index 50aa3e7a6..17c1fb278 100644
> >> --- a/client/main.c
> >> +++ b/client/main.c
> >> @@ -768,6 +768,29 @@ static GDBusProxy *find_proxy_by_address(GList *s=
ource, const char *address)
> >>         return NULL;
> >>  }
> >>
> >> +static GList *find_all_proxy_by_address(GList *source, const char *ad=
dress)
> >> +{
> >> +       GList *list;
> >> +       GList *all_proxy =3D NULL;
> >> +
> >> +       for (list =3D g_list_first(source); list; list =3D g_list_next=
(list)) {
> >> +               GDBusProxy *proxy =3D list->data;
> >> +               DBusMessageIter iter;
> >> +               const char *str;
> >> +
> >> +               if (g_dbus_proxy_get_property(proxy, "Address", &iter)=
 =3D=3D FALSE)
> >> +                       continue;
> >> +
> >> +               dbus_message_iter_get_basic(&iter, &str);
> >> +
> >> +               if (!strcasecmp(str, address))
> >> +                       all_proxy =3D g_list_append(all_proxy, proxy);
> >> +       }
> >> +
> >> +       return all_proxy;
> >> +}
> >> +
> >> +
> >>  static gboolean check_default_ctrl(void)
> >>  {
> >>         if (!default_ctrl) {
> >> @@ -2051,7 +2074,9 @@ static void cmd_disconn(int argc, char *argv[])
> >>
> >>  static void cmd_list_attributes(int argc, char *argv[])
> >>  {
> >> -       GDBusProxy *proxy;
> >> +       GList *all_proxy =3D NULL;
> >> +       GList *list;
> >> +       GDBusProxy *proxy =3D NULL;
> >>         const char *path;
> >>
> >>         if (argc > 1 && !strcmp(argv[1], "local")) {
> >> @@ -2059,11 +2084,33 @@ static void cmd_list_attributes(int argc, char=
 *argv[])
> >>                 goto done;
> >>         }
> >>
> >> -       proxy =3D find_device(argc, argv);
> >> -       if (!proxy)
> >> +       if (argc < 2 || !strlen(argv[1])) {
> >> +               if (default_dev) {
> >> +                       proxy =3D default_dev;
> >> +                       path =3D g_dbus_proxy_get_path(proxy);
> >> +                       goto done;
> >> +               }
> >> +               bt_shell_printf("Missing device address argument\n");
> >>                 return bt_shell_noninteractive_quit(EXIT_FAILURE);
> >> +       } else {
> >> +               if (check_default_ctrl() =3D=3D FALSE)
> >> +                       return bt_shell_noninteractive_quit(EXIT_FAILU=
RE);
> >>
> >> -       path =3D g_dbus_proxy_get_path(proxy);
> >> +               all_proxy =3D find_all_proxy_by_address(default_ctrl->=
devices,
> >> +                                                               argv[1=
]);
> >> +               if (!all_proxy) {
> >> +                       bt_shell_printf("Device %s not available\n", a=
rgv[1]);
> >> +                       return bt_shell_noninteractive_quit(EXIT_FAILU=
RE);
> >> +               }
> >> +               for (list =3D g_list_first(all_proxy); list;
> >> +                                               list =3D g_list_next(l=
ist)) {
> >> +                       proxy =3D list->data;
> >> +                       path =3D g_dbus_proxy_get_path(proxy);
> >> +                       gatt_list_attributes(path);
> >> +               }
> >> +               g_list_free(all_proxy);
> >> +               return bt_shell_noninteractive_quit(EXIT_SUCCESS);
> >> +       }
> >>
> >>  done:
> >>         gatt_list_attributes(path);
> >> --
> >> 2.25.1
> >>
> >>
> >
> >
>


--=20
Luiz Augusto von Dentz
