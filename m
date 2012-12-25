Return-Path: <cyrus@holtmann.org>
Message-ID: <1356401449.19248.27.camel@aeonflux>
Subject: [ANNOUNCE] Release of BlueZ 5.0
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Date: Mon, 24 Dec 2012 18:10:49 -0800
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello everyone,

it has been a yearly tradition to have a X-mas release. So it is with
great pleasure to announce that this year, the X-mas release is actually
the start of our next major development cycle. Please join me in
welcoming our BlueZ 5.0 release.

The 5.0 release has been 6 month in the making and a lot of things have
changed. The BlueZ package grew significantly over the last few month
since we consumed obexd and hcidump packages into it. This will deliver
a one stop experience for Bluetooth.

While including obexd and hcidump allows for better sharing of code and
deeper integration, we also took code out. The SBC codec support became
a separate library and has its own tree now. And we pushed the GStreamer
plugin into GStreamer upstream.

We switched the whole D-Bus API over to use the D-Bus Properties and
ObjectManager standard interfaces. This should make its usage a lot
simpler for client applications. In addition the new D-Bus API comes
with interface versions. This allows us to support multiple APIs at the
same time in the future.

Reflecting back at the 4.x development cycle, we released BlueZ 4.0 on
6th of August 2008 and BlueZ 4.101 on 22nd of June 2012. This means we
actually did 102 releases within 4 years. On average that is 2 releases
per month.

The 4.x cycle saw patches from 139 contributors and I like to thank
everybody who contributed fixes and features (in alphabetical order):

Adam Gołębiowski, Alex Elsayed, Alok Barsode, Anderson Briglia, Anderson
Lizardo, André Dieb Martins, Andre Guedes, Andrei Emeltchenko, Andrzej
Kaczmarek, Angela Bartholomaus, Ankush Bansal, Antti Julku, Arek Lichwa,
Arik Nemtsov, Arnaud Mouiche, Arun Kumar Singh, Arun Raghavan,
Balamurugan Mahalingam, Bartlomiej Grzeskowiak, Bastien Nocera, Bea Lam,
Brian Gix, Bruna Moreira, Bruno Dilly, Burt Silverman, Chan-yeol Park,
Chen Ganir, Christian Hoene, Claudio Takahasi, Colin Didier, Daniel
Orstadius, Daniel Wagner, David Herrmann, David Scherba, David
Stockwell, David Vrabel, David Woodhouse, Denis Kenzior, Dmitriy Paliy,
DoHyun Pyun, Elvis Pfützenreuter, Filippo Giunchedi, Forrest, Forrest
Zhao, Francisco Alecrim, Frédéric Dalleau, Frédéric Danis, Grant
Erickson, Gustavo F. Padovan, Harri Mahonen, Hemant Gupta, Ido Yariv,
Ilia Kolomisnky, Ilya Rubtsov, Inga Stotland, Jaganath Kanakkassery,
Jaikumar Ganesh, Jefferson Delfes, Jeff Hansen, Jiafa Liu, João Paulo
Rechi Vita, Johan Hedberg, Johan Hovold, John Crosbie, Joohi Rastogi,
Jorge Fernandez Gonzalez, José Antonio Santos Cadenas, Kay Sievers,
Keith Mok, Lennart Poettering, Lucas De Marchi, Luiz Augusto von Dentz,
Lukasz Pawlik, Lukasz Rymanowski, Łukasz Stelmach, Maarten Bosmans,
Marc-André Lureau, Marcel Holtmann, Marco Sinigaglia, Mario Limonciello,
Matthew Wilson, Michael Brudevold, Michal Labedzki, Mika Linnanoja,
Mikel Astiz, Mike Lockwood, Nick Pelly, Nobuhiro Iwamatsu, Ohad
Ben-Cohen, Olli-Pekka Salin, Pacho Ramos, Patrick Ohly, Paul Fertser,
Paulo Alcantara, Pavan Savoy, Pavel Raiskup, Pawel Wieczorkiewicz, Pekka
Pessi, Peter Hurley, Peter Krystad, Peter Zotov, Radoslaw Jablonski,
Rafael Fonseca, Rafal Michalski, Raymond Liu, RISKÓ Gergely, Santiago
Carot-Nemesio, Scott James Remnant, Scott Talbot, Sheldon Demario,
Siarhei Siamashka, Slawomir Bochenski, Smriti Gupta, Stefan Seyfried,
Steve Grubb, Steve Langasek, Steven Luo, Suraj Sumangala, Syam
Sidhardhan, Szymon Janc, Tedd Ho-Jeong An, Till Kamppeter, Timo Gienger,
Tom Gundersen, Tommi Keisala, Tom Rini, Uwe Kleine-König, Ville Tervo,
Vinicius Costa Gomes, Vishal Agarwal, Vladimir Botka, Vladimir Davydov,
Wade Brown, Waldemar Rymarkiewicz, Yegor Yefremov, Zhenhua Zhang, Zhu
Lan, Zhu Yanhai, Zygo Blaxell

Enjoy the holidays and Happy New Year.

Regards

Marcel


